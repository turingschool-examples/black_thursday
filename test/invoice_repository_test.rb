require_relative '../test/test_helper'
require_relative '../lib/invoice_repository'

class InvoiceRepositoryTest < Minitest::Test

  def test_it_exists
    parent = mock("parent")
    iir = InvoiceRepository.new("./test/fixtures/invoices_fixture.csv", parent)

    assert_instance_of InvoiceRepository, iir
  end

  def test_all_returns_array_of_invoices
    parent = mock("parent")
    iir = InvoiceRepository.new("./test/fixtures/invoices_fixture.csv", parent)

    iir.all.each do |invoice|
      assert_instance_of Invoice, invoice
    end
    assert_equal 1, iir.all[0].id
    assert_equal 12334185, iir.all[0].merchant_id
  end

  def test_find_by_id_returns_proper_invoice_or_nil
    parent = mock("parent")
    iir = InvoiceRepository.new("./test/fixtures/invoices_fixture.csv", parent)

    unknown_invoice = iir.find_by_id(1113)
    invoice = iir.find_by_id(3)

    assert_nil unknown_invoice
    assert_equal 3, invoice.id
    assert_equal 12334185, invoice.merchant_id
  end

  def test_find_all_by_customer_id_returns_array_of_invoices_with_matching_ids
    parent = mock("parent")
    iir = InvoiceRepository.new("./test/fixtures/invoices_fixture.csv", parent)

    unknown_invoice = iir.find_all_by_customer_id(1113)
    invoices = iir.find_all_by_customer_id(2)

    assert_equal [], unknown_invoice
    assert_equal 4, invoices.count
    assert_equal 12334105, invoices[0].merchant_id
  end

  def test_find_all_by_merchant_id_returns_array_of_invoices_with_matching_ids
    parent = mock("parent")
    iir = InvoiceRepository.new("./test/fixtures/invoices_fixture.csv", parent)

    unknown_invoice = iir.find_all_by_merchant_id(1113)
    invoices = iir.find_all_by_merchant_id(12334113)

    assert_equal [], unknown_invoice
    assert_equal 3, invoices.count
    assert_equal 13, invoices[0].id
  end

  def test_find_all_by_status_returns_array_of_invoices_with_matching_ids
    parent = mock("parent")
    iir = InvoiceRepository.new("./test/fixtures/invoices_fixture.csv", parent)

    unknown_invoice = iir.find_all_by_status("confiscated")
    invoices = iir.find_all_by_status("pending")

    assert_equal [], unknown_invoice
    assert_equal 9, invoices.count
    assert_equal 1, invoices[0].id
  end

end
