require_relative 'test_helper'

class InvoiceRepositoryTest < Minitest::Test

  attr_reader :invoice_repository

  def setup
    file = "./test/data_fixtures/invoices_fixture.csv"
    @invoice_repository = InvoiceRepository.new(file, Minitest::Mock.new)
  end

  def test_invoice_repo_exists
    assert invoice_repository
  end

  def test_all_returns_an_array
    assert_kind_of Array, invoice_repository.all
  end

  def test_all_returns_an_array_of_all_invoice_objects
    invoice_repository.all.all? {|invoice| assert_kind_of Invoice, invoice}
  end

  def test_all_includes_all_invoices
    assert_equal 56, invoice_repository.all.length
  end

  def test_find_by_id_finds_invoice_with_matching_id
    invoice = invoice_repository.find_by_id(136)
    assert_equal 27, invoice.customer_id
  end

  def test_find_by_id_returns_nil_when_there_is_no_invoice_matching_id
    assert_nil invoice_repository.find_by_id(99999999999)
  end

  def test_find_all_by_customer_id_returns_array_with_one_invoice
    invoices = invoice_repository.find_all_by_customer_id(27)
    assert_equal 1, invoices.length
    assert_equal 136, invoices.first.id
  end

  def test_find_all_by_customer_id_returns_all_invoices_for_a_customer
    invoices = invoice_repository.find_all_by_customer_id(1)
    assert_equal 8, invoices.length
  end

  def test_find_all_by_customer_id_returns_empty_array_for_customer_id_with_no_matches
    invoices = invoice_repository.find_all_by_customer_id(99999999)
    assert_equal [], invoices
  end

  def test_find_all_by_merchant_id_returns_array_with_one_invoice
    invoices = invoice_repository.find_all_by_merchant_id(12334753)
    assert_equal 1, invoices.length
    assert_equal 2, invoices.first.id
  end

  def test_find_all_by_merchant_id_returns_empty_array_when_there_are_no_matches
    invoices = invoice_repository.find_all_by_merchant_id(99999999)
    assert_equal [], invoices
  end

  def test_find_all_by_merchant_id_returns_array_with_all_invoices_for_customer
    invoices = invoice_repository.find_all_by_merchant_id(12334195)
    assert_equal 13, invoices.length
  end

  def test_find_all_by_status_finds_all_pending_invoices
    invoices = invoice_repository.find_all_by_status(:pending)
    assert_equal 20, invoices.length
  end

  def test_find_all_by_status_finds_all_shipped_invoices
    invoices = invoice_repository.find_all_by_status(:shipped)
    assert_equal 30, invoices.length
  end

  def test_find_all_by_status_finds_all_returned_invoices
    invoices = invoice_repository.find_all_by_status(:returned)
    assert_equal 6, invoices.length
  end

  def test_invoice_repo_knows_its_parent
    invoice_repository.parent.expect(:find_by_merchant_id, nil, [3333])
    invoice_repository.find_merchant(3333)
    invoice_repository.parent.verify
  end

end