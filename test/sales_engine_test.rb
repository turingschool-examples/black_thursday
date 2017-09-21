require_relative 'test_helper.rb'
require_relative '../lib/sales_engine.rb'

class SalesEngineTest < Minitest::Test
  attr_reader :engine

  def setup
    @engine = SalesEngine.new({ :items         => "./data/items.csv",
                                :merchants     => "./data/merchants.csv",
                                :invoices      => "./data/invoices.csv",
                                :customers     => "./data/customers.csv",
                                :invoice_items => "./data/invoice_items.csv",
                                :transactions  => "./data/transactions.csv"
                              })
  end

  def test_sales_engine_exists
    assert_instance_of SalesEngine, engine
  end

  def test_sales_engine_loads_merchant_repository
    assert_instance_of Merchant, engine.merchants.all[0]
    assert_instance_of Merchant, engine.merchants.all[-1]
    assert_equal 475, engine.merchants.all.length
  end

  def test_sales_engine_loads_item_repository
    assert_instance_of Item, engine.items.all[0]
    assert_instance_of Item, engine.items.all[-1]
    assert_equal 1367, engine.items.all.length
  end

  def test_sales_engine_loads_invoice_repository
    assert_instance_of Invoice, engine.invoices.all[0]
    assert_instance_of Invoice, engine.invoices.all[-1]
    assert_equal 4985, engine.invoices.all.length
  end

  def test_sales_engine_loads_customer_repository
    assert_instance_of Customer, engine.customers.all[0]
    assert_instance_of Customer, engine.customers.all[-1]
    assert_equal 1000, engine.customers.all.length
  end

  def test_sales_engine_loads_invoice_item_repository
    assert_instance_of InvoiceItem, engine.invoice_items.all[0]
    assert_instance_of InvoiceItem, engine.invoice_items.all[-1]
    assert_equal 21830, engine.invoice_items.all.length
  end

  def test_sales_engine_loads_transactions
    assert_instance_of Transaction, engine.transactions.all[0]
    assert_instance_of Transaction, engine.transactions.all[-1]
    assert_equal 4985, engine.transactions.all.length
  end

  def test_sales_engine_finds_merchant_by_id
    id       = 12335971
    merchant = engine.merchants.find_by_id(id)

    assert_equal id, merchant.id
  end

  def test_sales_engine_finds_all_items_by_merchant
    id       = 12335971
    merchant = engine.merchants.find_by_id(id)
    expected = merchant.items

    assert_equal 1, expected.length
  end

  def test_find_merchant_that_owns_item
    id       = 263538760
    item     = engine.items.find_by_id(id)
    expected = item.merchant

    assert_equal expected.id, item.merchant_id
    assert_equal 'Blankiesandfriends', expected.name
  end

  def test_sales_engine_finds_all_invoices_by_merchant
    id       = 12335690
    merchant = engine.merchants.find_by_id(id)
    expected = merchant.invoices

    assert_equal 16, expected.length
  end

  def test_sales_engine_finds_all_invoices_by_other_merchant
    id       = 12334189
    merchant = engine.merchants.find_by_id(id)
    expected = merchant.invoices

    assert_equal 10, expected.length
  end

  def test_sales_engine_merchant_returns_merchant_from_invoice
    invoice  = engine.invoices.find_by_id(20)
    merchant = invoice.merchant

    assert_instance_of Merchant, merchant
    assert_equal 12336163, invoice.merchant.id
  end

  def test_invoice_items_returns_invoice_related_invoice_items
    invoice = engine.invoices.find_by_id(106)

    expected = invoice.items
    assert_equal 7, expected.length
    assert_instance_of Item, expected.first
  end

  def test_invoice_transactions_returns_invoice_related_transactions
    invoice = engine.invoices.find_by_id(106)

    expected = invoice.transactions
    assert_equal 1, expected.length
    assert_instance_of Transaction, expected.first
  end

  def test_invoice_customer_returns_customer_related_to_invoice
    invoice = engine.invoices.find_by_id(106)

    expected = invoice.customer
    assert_equal 22, expected.id
    assert_instance_of Customer, expected
  end

  def test_transaction_invoice_returns_related_invoice
    transaction = engine.transactions.find_by_id(1452)
    expected = transaction.invoice

    assert_equal 4746, expected.id
    assert_instance_of Invoice, expected
  end

  def test_merchant_customers_returns_related_customers
    expected = engine.merchants.find_by_id(12334194).customers

    assert_equal 12, expected.length
    assert_instance_of Customer, expected.first
  end

  def test_customer_merchants_returns_merchants_related_to_customer
    customer = engine.customers.find_by_id(30)
    expected = customer.merchants

    assert_equal 5, expected.length
    assert_instance_of Merchant, expected.first
  end
end
