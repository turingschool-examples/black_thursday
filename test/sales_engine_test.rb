require './test/test_helper'
require './lib/sales_engine'

# Tests Sales Engine class
class SalesEngineTest < Minitest::Test
  def setup
    @se = SalesEngine.from_csv({
          items: './data/sample_data/items.csv',
      merchants: './data/sample_data/merchants.csv',
       invoices: './data/sample_data/invoices.csv',
   transactions: './data/sample_data/transactions.csv',
      customers: './data/sample_data/customers.csv',
  invoice_items: './data/sample_data/items.csv'
  })
  end

  def test_sales_engine_class_exists
    assert_instance_of SalesEngine, @se
  end

  def test_it_creates_instances_of_repositories
    assert_instance_of ItemRepository, @se.items
    assert_instance_of MerchantRepository, @se.merchants
    assert_instance_of InvoiceRepository, @se.invoices
    assert_instance_of CustomerRepository, @se.customers
    assert_instance_of InvoiceItemRepository, @se.invoices_items
    assert_instance_of TransactionRepository, @se.transactions
  end

  def test_it_finds_items_by_merchant_id
    merchant = @se.merchants.find_by_id(123_341_05)
    item_ids = [1, 2]

    (0...item_ids.length).each do |index|
      assert_equal item_ids[index], merchant.items[index].id
      assert_instance_of Item, merchant.items[index]
    end
  end

  def test_it_finds_merchant_by_item_id
    item = @se.items.find_by_id(1)

    assert_instance_of Merchant, item.merchant
    assert_equal 123_341_05, item.merchant.id
  end

  def test_it_finds_invoices_by_merchant_id
    merchant = @se.merchants.find_by_id(12334105)

    assert_instance_of Invoice, merchant.invoices[0]
    assert_equal :shipped, merchant.invoices[0].status
    assert_equal 46, merchant.invoices[0].id
  end

  def test_it_finds_merchant_by_invoice_id
    invoice = @se.invoices.find_by_id(2)

    assert_instance_of Merchant, invoice.merchant
    assert_equal 12334115, invoice.merchant.id
  end

  def test_it_finds_invoice_by_transaction_id
    transaction = @se.transactions.find_by_id(2)

    assert_instance_of Invoice, transaction.invoice
    assert_equal 46, transaction.invoice.id
  end

  def test_it_finds_merchants_by_customer_id
    customer = @se.customers.find_by_id(30)

    assert_instance_of Merchant, customer.merchants[0]
    assert_equal 3, customer.merchants[0].id
  end

  def test_it_finds_customers_by_merchant_id
    merchant = @se.merchants.find_by_id(12334105)

    assert_instance_of Customer, merchant.customers[0]
    assert_equal 'Joey', merchant.customers[0].first_name
  end

  def test_it_finds_items_by_invoice_id
    invoice = @se.invoices.find_by_id(46)

    assert_instance_of Item, invoice.items[0]
    assert_equal 46, invoice.items[0].name
  end
end
