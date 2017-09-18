require_relative 'test_helper'
require './lib/sales_engine'
require 'csv'

class InvoiceRepositoryTest < Minitest::Test

  def setup
    item_file_path = './test/fixtures/items_truncated.csv'
    merchant_file_path = './test/fixtures/merchants_truncated.csv'
    invoice_file_path = './test/fixtures/invoices_truncated.csv'
    customer_file_path = './test/fixtures/customers_truncated.csv'
    transaction_file_path = './test/fixtures/transactions_truncated.csv'
    engine = SalesEngine.new(item_file_path, merchant_file_path, invoice_file_path, customer_file_path, transaction_file_path)
    @repository = engine.invoice_items
    @invoice_items = engine.invoice_items_list
  end

  def test_it_exists
    assert_instance_of InvoiceItemRepository, @repository
  end

  def test_it_creates_invoice_objects_for_each_row
    assert_instance_of InvoiceItem, @invoice_items[0]
  end

  def test_all_returns_array_of_all_invoice_objects
    assert_equal 26, @invoice_items.count
  end

  def test_find_all_by_item_id_returns_empty_if_no_match
    assert_empty(@repository.find_all_by_item_id(0))
  end

  def test_it_finds_all_items_with_matching_item_id
    invoice_items = @repository.find_all_by_item_id(263443369)

    assert_equal 1, invoices_items.count

    invoice_items = @repository.find_all_by_item_id('263443369')

    assert_equal 1, invoices.count
  end

  def test_find_all_by_invoice_id_returns_empty_if_no_match
    assert_empty(@repository.find_all_by_invoice_id(0))
  end

  def test_it_finds_all_items_with_matching_invoice_id
    invoice_items = @repository.find_all_by_invoice_id(1495)

    assert_equal 6, invoices.count
  end

end
