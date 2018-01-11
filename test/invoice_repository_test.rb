require_relative '../test/test_helper'
require_relative '../lib/invoice_repository'

class InvoiceRepositoryTest < Minitest::Test

  def test_it_exists
    parent = mock("parent")
    inr = InvoiceRepository.new("./test/fixtures/invoices_fixture.csv", parent)

    assert_instance_of InvoiceRepository, inr
  end

  def test_all_returns_array_of_invoices
    parent = mock("parent")
    inr = InvoiceRepository.new("./test/fixtures/invoices_fixture.csv", parent)

    inr.all.each {|invoice| assert_instance_of Invoice, invoice}
    assert_equal 1, inr.all.first.id
    assert_equal 12334185, inr.all.first.merchant_id
    assert_equal 20, inr.all.last.id
    assert_equal 12334141, inr.all.last.merchant_id
  end

  def test_find_by_id_returns_proper_invoice_or_nil
    parent = mock("parent")
    inr = InvoiceRepository.new("./test/fixtures/invoices_fixture.csv", parent)

    unknown_invoice = inr.find_by_id(1113)
    invoice = inr.find_by_id(3)

    assert_nil unknown_invoice
    assert_equal 3, invoice.id
    assert_equal 12334185, invoice.merchant_id
  end

  def test_find_all_by_customer_id_returns_array_of_invoices_with_matching_ids
    parent = mock("parent")
    inr = InvoiceRepository.new("./test/fixtures/invoices_fixture.csv", parent)

    unknown_invoice = inr.find_all_by_customer_id(1113)
    invoices = inr.find_all_by_customer_id(2)

    assert_equal [], unknown_invoice
    assert_equal 4, invoices.count
    assert_equal 12334141, invoices.first.merchant_id
    assert_equal 12334105, invoices.last.merchant_id
  end

  def test_find_all_by_merchant_id_returns_array_of_invoices_with_matching_ids
    parent = mock("parent")
    inr = InvoiceRepository.new("./test/fixtures/invoices_fixture.csv", parent)

    unknown_invoice = inr.find_all_by_merchant_id(1113)
    invoices = inr.find_all_by_merchant_id(12334113)

    assert_equal [], unknown_invoice
    assert_equal 3, invoices.count
    assert_equal 2, invoices.first.id
    assert_equal 14, invoices.last.id
  end

  def test_find_all_by_status_returns_array_of_invoices_with_matching_ids
    parent = mock("parent")
    inr = InvoiceRepository.new("./test/fixtures/invoices_fixture.csv", parent)

    unknown_invoice = inr.find_all_by_status("confiscated")
    invoices_1 = inr.find_all_by_status(:pending)
    invoices_2 = inr.find_all_by_status("shipped")

    assert_equal [], unknown_invoice
    assert_equal 9, invoices_1.count
    assert_equal 1, invoices_1.first.id
    assert_equal 17, invoices_1.last.id
    assert_equal 11, invoices_2.count
    assert_equal 2, invoices_2.first.id
    assert_equal 20, invoices_2.last.id
  end

  def test_find_by_date_returns_invoices_for_given_date
    parent = mock("parent")
    inr = InvoiceRepository.new("./test/fixtures/invoices_fixture.csv", parent)

    invoices = inr.find_by_date("2012-11-23")
    unknown_invoice = inr.find_by_date("2045-09-11")

    assert_equal [], unknown_invoice
    assert_equal 2, invoices.count
    assert_equal 12334113, invoices.first.merchant_id
    assert_equal 12334141, invoices.last.merchant_id
  end

end
