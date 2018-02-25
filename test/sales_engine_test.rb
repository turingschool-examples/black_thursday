require './test/test_helper'
require './lib/sales_engine'

# Tests Sales Engine class
class SalesEngineTest < Minitest::Test
  def setup
    @se = SalesEngine.from_csv(
      items: './data/sample_data/items.csv',
      merchants: './data/sample_data/merchants.csv',
      invoices: './data/sample_data/invoices.csv',
      transactions: './data/sample_data/transactions.csv',
      customers: './data/sample_data/customers.csv',
      invoice_items: './data/sample_data/items.csv'
    )
  end

  def test_sales_engine_class_exists
    assert_instance_of SalesEngine, @se
  end

  def test_it_creates_new_repositories
    assert_instance_of ItemRepository, @se.items
    assert_instance_of MerchantRepository, @se.merchants
    assert_instance_of InvoiceRepository, @se.invoices
    assert_instance_of TransactionRepository, @se.transactions
    assert_instance_of CustomerRepository, @se.customers
    assert_instance_of InvoiceItemRepository, @se.invoice_items
  end

  def test_find_merchant_items
    merchant = @se.merchants.find_by_id(123_341_05)
    item_ids = [1, 2]

    (0...item_ids.length).each do |index|
      assert_equal item_ids[index], merchant.items[index].id
      assert_instance_of Item, merchant.items[index]
    end
  end

  def test_find_item_merchant
    item = @se.items.find_by_id(1)

    assert_instance_of Merchant, item.merchant
    assert_equal 12_334_105, item.merchant.id
  end

  def test_find_merchant_invoices
    merchant = @se.merchants.find_by_id(12_334_105)

    assert_instance_of Invoice, merchant.invoices[0]
    assert_equal :shipped, merchant.invoices[0].status
    assert_equal 46, merchant.invoices[0].id
  end

  def test_find_invoice_merchant
    invoice = @se.invoices.find_by_id(2)

    assert_instance_of Merchant, invoice.merchant
    assert_equal 12334115, invoice.merchant.id
  end

  def test_find_transaction_invoice
    transaction = @se.transactions.find_by_id(2)

    assert_instance_of Invoice, transaction.invoice
    assert_equal 46, transaction.invoice.id
  end

  def test_find_invoice_items
    invoice = @se.invoices.find_by_id(46)

    assert_instance_of Item, invoice.items[0]
    assert_equal 46, invoice.items[0].name
  end

  def test_find_customer_merchants
    customer = @se.customers.find_by_id(3)

    assert_instance_of Merchant, customer.merchants[0]
    assert_equal 3, customer.merchants[0].id
  end

  def test_find_merchant_customers
    merchant = @se.merchants.find_by_id(12_334_105)

    assert_instance_of Customer, merchant.customers[0]
    assert_equal 'Joey', merchant.customers[0].first_name
  end
end
