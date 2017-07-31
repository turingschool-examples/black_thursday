require_relative 'test_helper'
require_relative '../lib/sales_engine'
require 'pry'

class SalesEngineTest < Minitest::Test

  def test_initialize
    salesengine = SalesEngine.from_csv({
      :items => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoices => "./data/invoices.csv"
    })

    assert_instance_of SalesEngine, salesengine
    assert_instance_of ItemRepository, salesengine.items
    assert_instance_of MerchantRepository, salesengine.merchants
  end

  def test_sales_engine_exists
    se = SalesEngine.from_csv({
      :items => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoices => "./data/invoices.csv"
    })

    assert_instance_of SalesEngine, se
  end

  def test_sales_engine_initializes_with_merchant_repository
    se = SalesEngine.from_csv({
      :merchants => "./data/merchants.csv"
    })

    assert_instance_of MerchantRepository, se.merchants
  end

  def test_sales_engine_initializes_with_item_repository
    se = SalesEngine.from_csv({
      :items => "./data/items.csv"
    })

    assert_instance_of ItemRepository, se.items
  end

  def test_sales_engine_initializes_with_invoice_repository
    se = SalesEngine.from_csv({
      :invoices => "./data/invoices.csv"
    })

    assert_instance_of InvoiceRepository, se.invoices
  end

  def test_sales_engine_initializes_with_invoice_items_repo
    se = SalesEngine.from_csv({
      :invoice_items => "./data/invoice_items.csv"
      })

    assert_instance_of InvoiceItemRepository, se.invoice_items
  end

  def test_sales_engine_initializes_with_transactions_repo
    se = SalesEngine.from_csv({
      :transactions => "./data/transactions.csv"
      })

    assert_instance_of TransactionRepository, se.transactions
  end

  def test_sales_engine_initializes_with_customer_repo
    se = SalesEngine.from_csv({
      :customers => "./data/customers.csv"
      })

    assert_instance_of CustomerRepository, se.customers
  end

  def test_merchant_by_merchant_id_gets_merchant
    se = SalesEngine.from_csv({
      :merchants => "./data/merchants.csv"
    })
    merchant = se.merchant_by_merchant_id(12335119)

    assert_instance_of Merchant, merchant
  end

  def test_items_by_merchant_id_gets_items
    se = SalesEngine.from_csv({
      :items => "./data/items.csv"
    })
    items = se.items_by_merchant_id(12335119)

    assert_instance_of Item, items[0]
    assert_equal 2, items.count
  end

  def test_invoices_by_merchant_id_gets_invoices
    se = SalesEngine.from_csv({
      :invoices => "./data/invoices.csv"
    })
    invoices = se.invoices_by_merchant_id(12335119)

    assert_instance_of Invoice, invoices[0]
    assert_equal 9, invoices.count
  end

  def test_invoice_items_by_invoice_id_gets_invoice_items
    se = SalesEngine.from_csv({
      :invoice_items => './data/invoice_items.csv'
      })
    invoice_items = se.invoice_items_by_invoice_id(168)

    assert_instance_of InvoiceItem, invoice_items[0]
    assert_equal 3, invoice_items.count
  end

  def test_items_by_invoice_id_gets_all_items_for_a_given_invoice
    se = SalesEngine.from_csv({
      :items => './data/items.csv',
      :invoice_items => './data/invoice_items.csv'
      })
    items = se.items_by_invoice_id(168)
    assert_instance_of Item, items[0]
    assert_equal 3, items.count
  end

  def test_transactions_by_invoice_id_gets_transactions_for_given_invoice
    se = SalesEngine.from_csv({
      :transactions => './data/transactions.csv'
      })
    transactions = se.transactions_by_invoice_id(20)

    assert_instance_of Transaction, transactions[0]
    assert_equal 3, transactions.count
  end

  def test_customer_by_customer_id_gets_customer_for_given_customer_id
    se = SalesEngine.from_csv({
      :customers => './data/customers.csv'
      })
    customer = se.customer_by_customer_id(22)

    assert_instance_of Customer, customer
    assert_equal "Constance", customer.first_name
  end

  def test_invoice_by_invoice_id_gets_invoice
    se = SalesEngine.from_csv({
      :invoices => './data/invoices.csv'
      })
    invoice = se.invoice_by_invoice_id(2779)

    assert_instance_of Invoice, invoice
    assert_equal 12334634, invoice.merchant_id
  end

  def test_customers_by_merchant_id_gets_customers
    se = SalesEngine.from_csv({
      :invoices => './data/invoices.csv',
      :customers => './data/customers.csv'
      })
    customers = se.customers_by_merchant_id(12334207)

    assert_instance_of Array, customers
    assert_equal 11, customers.count

    customers_2 = se.customers_by_merchant_id(12334194)

    assert_instance_of Array, customers_2
    assert_equal 12, customers_2.count
  end

end
