require_relative 'test_helper'
require './lib/sales_engine'
require 'csv'

class InvoiceRepositoryTest < Minitest::Test

  def setup
    item_file_path = './test/fixtures/items_truncated.csv'
    merchant_file_path = './test/fixtures/merchants_truncated.csv'
    invoice_file_path = './test/fixtures/invoices_truncated.csv'
    engine = SalesEngine.new(item_file_path, merchant_file_path, invoice_file_path)
    @repository = engine.items
  end


  def test_it_exists
    assert_instance_of InvoiceRepository, @repository
  end

  def test_it_creates_invoice_objects_for_each_row
    assert_instance_of Invoice, @repository.invoices.first
  end

  def test_all_returns_array_of_all_invoice_objects
    assert_equal 12, @repository.items.count
  end

  def test_find_by_id_returns_nil_if_no_id_found
    assert_nil(@repository.find_by_id(000000))
  end

  def test_find_by_id_returns_item_of_matching_id
    invoice = @repository.find_by_id(1)

    assert_equal 12335938, invoice.merchant_id

    invoice = @repository.find_by_id('1')

    assert_equal 1, invoice.customer_id
  end

  def test_it_finds_all_items_with_matching_merchant_id
    assert_empty(@repository.find_all_by_merchant_id(0))
  end

  def test_it_finds_all_items_with_matching_merchant_id
    invoices = @repository.find_all_by_merchant_id(12334185)

    assert_equal 10, invoices.count

    invoices = @repository.find_all_by_merchant_id('12334185')

    assert_equal 10, invoices.count
  end

  def test_it_finds_all_items_with_matching_customer_id
    assert_empty(@repository.find_all_by_customer_id(0))
  end

  def test_it_finds_all_items_with_matching_customer_id
    invoices = @repository.find_all_by_customer_id(297)

    assert_equal 1, invoices.count
    assert_equal 1495, invoices[0].id

    invoices = @repository.find_all_by_customer_id('297')

    assert_equal 1, invoices.count
    assert_equal 1495, invoices[0].id
  end

  def test_it_finds_all_items_with_matching_status
    invoices = @repository.find_all_by_status('returned')

    assert_equal 1, invoices.count
    assert_equal 1495, invoices[0].id

    invoices = @repository.find_all_by_status('shipped')

    assert_equal 5, invoices.count

    invoices = @repository.find_all_by_status('Pending')

    assert_equal 5, invoices.count
  end


end
