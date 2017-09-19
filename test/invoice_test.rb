require_relative 'test_helper'
require './lib/sales_engine'

class InvoiceTest < Minitest::Test

  def setup
    item_file_path = './test/fixtures/larger_items_sample.csv'
    merchant_file_path = './test/fixtures/merchants_truncated.csv'
    invoice_file_path = './test/fixtures/invoices_truncated.csv'
    invoice_item_file_path = './test/fixtures/invoice_items_truncated.csv'
    customer_file_path = './test/fixtures/customers_truncated.csv'
    transaction_file_path = './test/fixtures/transactions_truncated.csv'
    @engine = SalesEngine.new(item_file_path, merchant_file_path, invoice_file_path, invoice_item_file_path, customer_file_path, transaction_file_path)
    @invoice_repo = @engine.invoices
    @invoices = @engine.invoice_list
  end

  def test_it_exists
    assert_instance_of Invoice, @invoices[0]
  end

  def test_it_can_retrieve_invoice_attributes
    invoice = @invoices[0]

    assert_equal 1495, invoice.id
    assert_equal 297, invoice.customer_id
    assert_equal :returned, invoice.status
    assert_equal 12334185, invoice.merchant_id
    assert_instance_of Time, invoice.created_at
    assert_instance_of Time, invoice.updated_at
    assert_instance_of SalesEngine, invoice.engine
  end

  def test_merchant_returns_merchant_object_with_matching_id
    invoice = @invoice_repo.find_by_id(1495)

    assert_instance_of Merchant, invoice.merchant
    assert_equal 'Madewithgitterxx', invoice.merchant.name
  end

  def test_find_item_ids_finds_all_item_ids_with_corresponding_invoice_id
    invoice = @invoice_repo.find_by_id(1495)
    invoice_items = @engine.invoice_items.find_all_by_invoice_id(invoice.id)

    assert_equal [263443369, 263529916, 263409041, 263555656, 263397919, 263422161], invoice.find_item_ids(invoice_items)
  end

  def test_find_items_from_item_ids_returns_items_that_match_item_ids
    invoice = @invoice_repo.find_by_id(1495)
    ids = [263443369, 263529916, 263409041, 263555656, 263397919, 263422161]
    items = invoice.find_items_from_item_ids(ids)

    assert_instance_of Item, items[0]
    assert_equal 1, items.count
    assert_equal 263397919, items[0].id
  end

  def test_items_returns_all_items_for_invoice_id
    invoice = @invoice_repo.find_by_id(1495)
    items_for_invoice = invoice.items

    assert_equal 1, items_for_invoice.count
    assert_equal 263397919, items_for_invoice[0].id
  end

  def test_transactions_returns_all_transactions_for_invoice_id
    invoice = @invoice_repo.find_by_id(1495)
    transactions_for_invoice = invoice.transactions

    assert_equal 2, transactions_for_invoice.count
    assert_equal 263397919, transactions_for_invoice[0].id
  end

  def test_transactions_returns_all_transactions_for_invoice_id
    invoice = @invoice_repo.find_by_id(1495)
    customer_for_invoice = invoice.customer

    assert_instance_of Customer, customer_for_invoice
    assert_equal 297, customer_for_invoice.id
  end

  def test_it_knows_if_it_is_paid_in_full
    invoice = @invoice_repo.find_by_id(1495)

    assert invoice.is_paid_in_full?

    invoice = @invoice_repo.find_by_id(1695)

    refute invoice.is_paid_in_full?
  end

  def test_it_can_find_total_revenue
    invoice = @invoice_repo.find_by_id(1495)

    assert_equal 15620.53, invoice.total
  end


end
