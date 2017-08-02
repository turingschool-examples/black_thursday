require_relative 'test_helper'
require './lib/sales_engine'
require 'csv'


class SalesEngineTest < Minitest::Test
  def setup
    @se = SalesEngine.from_csv({
      :items => "./data/mini_items.csv",
      :merchants => "./data/mini_merchants.csv",
      :invoices => "./data/mini_invoices.csv",
      :invoice_items => "./data/mini_invoice_items.csv",
      :transactions => "./data/mini_transactions.csv",
      :customers => "./data/mini_customers.csv"
      })
  end

  def test_sales_engine_class_exists
    assert_instance_of SalesEngine, @se
  end

  def test_it_can_create_a_new_instance_of_merchant_repo_class
    assert_instance_of MerchantRepository, @se.merchants
  end

  def test_it_can_create_a_new_instance_of_item_repo_class
    assert_instance_of ItemRepository, @se.items
  end

  def test_it_can_create_a_new_instance_of_invoice_repo_class
    assert_instance_of InvoiceRepository, @se.invoices
  end

  def test_it_can_create_a_new_instance_of_invoice_item_repo_class
    assert_instance_of InvoiceItemRepository, @se.invoice_items
  end

  def test_it_can_create_a_new_instance_of_transaction_repo_class
    assert_instance_of TransactionRepository, @se.transactions
  end

  def test_it_can_create_a_new_instance_of_customer_repo_class
    assert_instance_of CustomerRepository, @se.customers
  end

  def test_it_returns_item_searched_by_name
    items = @se.items
    assert_instance_of Item, items.find_by_name("Glitter scrabble frames")
  end

  def test_it_can_find_merchant_by_name
    mr = @se.merchants

    assert_instance_of Merchant, mr.find_by_name("Shopin1901")
  end

  def test_it_can_find_item_by_name
    items = @se.items

    assert_instance_of Item, items.find_by_name("510+ RealPush Icon Set")
  end

  def test_it_can_find_another_item_by_name
    items = @se.items
    assert_instance_of Item, items.find_by_name("Glitter scrabble frames")
  end

  def test_it_can_return_array_of_items_by_merchant_id
    merchant = @se.merchants.find_by_id(12334112)

    assert_instance_of Array, merchant.items
  end

  def test_it_can_return_merchant_by_item_id
    item = @se.items.find_by_id(263395237)

    assert_nil item.merchant
  end

  def test_it_can_return_array_of_invoices_by_merchant_id
    merchant = @se.merchants.find_by_id(12334105)
    assert_equal 0, merchant.invoices.length
    assert_equal [], merchant.invoices
  end

  def test_it_can_return_merchant_by_invoice_id
    invoice = @se.invoices.find_by_id(1)

    assert_nil invoice.merchant
  end

  def test_it_can_find_invoice_items_by_invoice_id
    se = SalesEngine.from_csv({
      :items => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoices => "./data/invoices.csv",
      :invoice_items => "./data/invoice_items.csv",
      :transactions => "./data/transactions.csv",
      :customers => "./data/customers.csv"
      })
    invoice = se.invoices.find_by_id(20)
    assert_instance_of Array, invoice.items
  end

  def test_it_can_find_transactions_by_invoice_id
    se = SalesEngine.from_csv({
      :items => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoices => "./data/invoices.csv",
      :invoice_items => "./data/invoice_items.csv",
      :transactions => "./data/transactions.csv",
      :customers => "./data/customers.csv"
      })
    invoice = se.invoices.find_by_id(20)
    assert_instance_of Array, invoice.transactions
  end

  def test_it_can_find_customer_by_invoice_id
    se = SalesEngine.from_csv({
      :items => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoices => "./data/invoices.csv",
      :invoice_items => "./data/invoice_items.csv",
      :transactions => "./data/transactions.csv",
      :customers => "./data/customers.csv"
      })
    invoice = se.invoices.find_by_id(20)
    assert_instance_of Customer, invoice.customer
  end

  def test_it_can_find_invoice_by_transaction_id
    se = SalesEngine.from_csv({
      :items => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoices => "./data/invoices.csv",
      :invoice_items => "./data/invoice_items.csv",
      :transactions => "./data/transactions.csv",
      :customers => "./data/customers.csv"
      })
    transaction = se.transactions.find_by_id(40)

    assert_instance_of Invoice, transaction.invoice
  end

  def test_it_can_find_customers_by_merchant_id
    se = SalesEngine.from_csv({
      :items => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoices => "./data/invoices.csv",
      :invoice_items => "./data/invoice_items.csv",
      :transactions => "./data/transactions.csv",
      :customers => "./data/customers.csv"
      })
    merchant = se.merchants.find_by_id(12335938)
    assert_instance_of Array, merchant.customers
    assert_equal 16, merchant.customers.count
  end

  def test_it_can_find_merchants_by_customer_id
    customer = @se.customers.find_by_id(1)
    assert_instance_of Array, customer.merchants
  end
end
