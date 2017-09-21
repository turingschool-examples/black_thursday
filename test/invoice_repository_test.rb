require_relative 'test_helper'
require './lib/sales_engine'
require 'csv'

class InvoiceRepositoryTest < Minitest::Test

  def setup
    item_file_path = './test/fixtures/items_truncated.csv'
    merchant_file_path = './test/fixtures/merchants_truncated.csv'
    invoice_file_path = './test/fixtures/invoices_truncated.csv'
    invoice_item_file_path = './test/fixtures/invoice_items_truncated.csv'
    customer_file_path = './test/fixtures/customers_truncated.csv'
    transaction_file_path = './test/fixtures/transactions_truncated.csv'
    engine = SalesEngine.new(item_file_path, merchant_file_path,
    invoice_file_path, invoice_item_file_path, customer_file_path,
    transaction_file_path)
    @repository = engine.invoices
    @invoices = engine.invoice_list
  end


  def test_it_exists
    assert_instance_of InvoiceRepository, @repository
  end

  def test_it_creates_invoice_objects_for_each_row
    assert_instance_of Invoice, @invoices[0]
  end

  def test_all_returns_array_of_all_invoice_objects
    assert_equal 14, @invoices.count
  end

  def test_find_by_id_returns_nil_if_no_id_found
    assert_nil(@repository.find_by_id(000000))
  end

  def test_find_by_id_returns_invoice_of_matching_id
    invoice = @repository.find_by_id(269)

    assert_equal 12334112, invoice.merchant_id

    invoice = @repository.find_by_id('269')

    assert_equal 51, invoice.customer_id
  end

  def test_find_all_invoices_by_merchant_id_returns_empty_if_no_match
    assert_empty(@repository.find_all_by_merchant_id(0))
  end

  def test_it_finds_all_invoices_with_matching_merchant_id
    invoices = @repository.find_all_by_merchant_id(12334185)

    assert_equal 10, invoices.count

    invoices = @repository.find_all_by_merchant_id('12334185')

    assert_equal 10, invoices.count
  end

  def test_find_all_invoices_by_customer_id_returns_empty_if_no_match
    assert_empty(@repository.find_all_by_customer_id(0))
  end

  def test_it_finds_all_invoices_with_matching_customer_id
    invoices = @repository.find_all_by_customer_id(297)

    assert_equal 1, invoices.count
    assert_equal 1495, invoices[0].id

    invoices = @repository.find_all_by_customer_id('297')

    assert_equal 1, invoices.count
    assert_equal 1495, invoices[0].id
  end

  def test_it_finds_all_invoices_with_matching_status
    invoices = @repository.find_all_by_status(:returned)

    assert_equal 4, invoices.count
    assert_equal 1495, invoices[0].id

    invoices = @repository.find_all_by_status(:shipped)

    assert_equal 6, invoices.count

    invoices = @repository.find_all_by_status(:pending)

    assert_equal 4, invoices.count
  end

  def test_it_finds_all_by_date_returns_empty_array_if_no_match
    invoices = @repository.find_all_by_date('2003-05-01')

    assert_empty(invoices)
  end

  def test_it_finds_all_by_date
    invoices = @repository.find_all_by_date('2003-05-16')

    assert_equal 1, invoices.count
  end

  def test_it_finds_all_invoices_paid_in_full
    paid_in_full_invoices = @repository.find_all_paid_in_full

    assert_equal 7, paid_in_full_invoices.count
    assert_equal 1495, paid_in_full_invoices[0].id
  end



end
