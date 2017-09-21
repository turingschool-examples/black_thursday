require "./test/test_helper"
require "./lib/sales_engine"
require "./lib/invoice_repository"
require './lib/invoice'

class InvoiceRepositoryTest < Minitest::Test

  attr_reader :invoice_repository

  def setup
    invoice_csv = "./test/test_fixtures/invoices_medium.csv"
    @invoice_repository= InvoiceRepository.new('fake_se', invoice_csv)
  end

  def test_it_exists
    assert_instance_of InvoiceRepository, invoice_repository
  end

  def test_it_makes_array_of_all_invoices
    assert_instance_of Array, invoice_repository.all
    assert_instance_of Invoice, invoice_repository.all[0]
  end

  def test_it_returns_nil_for_invalid_id
    assert_nil invoice_repository.find_by_id(17283451064)
  end

  def test_it_returns_invoice_instance_for_id
    assert_instance_of Invoice, invoice_repository.find_by_id(1)
  end

  def test_it_returns_invoice_instance_for_customer_id
    assert_equal [], invoice_repository.find_all_by_customer_id(1234)
  end

  def test_it_returns_invoice_instance_for_customer_id
    assert_instance_of Invoice, invoice_repository.find_all_by_customer_id(1)[0]
  end

  def test_it_returns_invoice_instance_for_merchant_id
    assert_equal [], invoice_repository.find_all_by_merchant_id(1234)
  end

  def test_it_returns_invoice_instance_for_merchant_id
      assert_instance_of Invoice, invoice_repository.find_all_by_merchant_id(12335938)[0]
  end

  def test_it_returns_invoice_instance_for_status
    assert_equal [], invoice_repository.find_all_by_status("fake")
  end

  def test_it_returns_invoice_instance_for_status
    assert_instance_of Invoice, invoice_repository.find_all_by_status(:pending)[0]
  end

  def test_inspect
    assert_instance_of String, invoice_repository.inspect
  end

end
