require_relative 'test_helper'
require_relative '../lib/sales_engine'
require 'bigdecimal'

class SalesEngineTest < Minitest::Test
  include DataParser

  def test_sales_engine_knows_about_merchant_repo
    se = SalesEngine.from_csv({
      :items         => "./data/items.csv",
      :merchants     => "./data/merchants.csv",
      :invoices      => "./data/invoices.csv",
      :invoice_items => "./data/invoice_items.csv",
      :transactions  => "./data/transactions.csv",
      :customers     => "./data/customers.csv"
      })
      assert_instance_of Merchant, se.merchants.all.first
      assert_equal 475, se.merchants.all.count
      assert_instance_of Merchant, se.merchants.all.last
  end

  def test_sales_engine_knows_about_item_repo
    se = SalesEngine.from_csv({
      :items         => "./data/items.csv",
      :merchants     => "./data/merchants.csv",
      :invoices      => "./data/invoices.csv",
      :invoice_items => "./data/invoice_items.csv",
      :transactions  => "./data/transactions.csv",
      :customers     => "./data/customers.csv"
      })
      assert_instance_of Item, se.items.all.first
      assert_equal 1367, se.items.all.count
      assert_instance_of Item, se.items.all.last
  end

  def test_sales_engine_knows_about_invoice_repo
    se = SalesEngine.from_csv({
      :items         => "./data/items.csv",
      :merchants     => "./data/merchants.csv",
      :invoices      => "./data/invoices.csv",
      :invoice_items => "./data/invoice_items.csv",
      :transactions  => "./data/transactions.csv",
      :customers     => "./data/customers.csv"
      })
      assert_instance_of Invoice, se.invoices.all.first
      assert_equal 4985, se.invoices.all.count
      assert_instance_of Invoice, se.invoices.all.last
  end

  def test_sales_engine_knows_about_invoice_item_repo
    se = SalesEngine.from_csv({
      :items         => "./data/items.csv",
      :merchants     => "./data/merchants.csv",
      :invoices      => "./data/invoices.csv",
      :invoice_items => "./data/invoice_items.csv",
      :transactions  => "./data/transactions.csv",
      :customers     => "./data/customers.csv"
      })
      assert_instance_of InvoiceItem, se.invoice_items.all.first
      assert_equal 21830, se.invoice_items.all.count
      assert_instance_of InvoiceItem, se.invoice_items.all.last
  end

  def test_sales_engine_knows_about_transaction_repo
    se = SalesEngine.from_csv({
      :items         => "./data/items.csv",
      :merchants     => "./data/merchants.csv",
      :invoices      => "./data/invoices.csv",
      :invoice_items => "./data/invoice_items.csv",
      :transactions  => "./data/transactions.csv",
      :customers     => "./data/customers.csv"
      })
      assert_instance_of Transaction, se.transactions.all.first
      assert_equal 4985, se.transactions.all.count
      assert_instance_of Transaction, se.transactions.all.last
  end

  def test_sales_engine_knows_about_customers_repo
    se = SalesEngine.from_csv({
      :items         => "./data/items.csv",
      :merchants     => "./data/merchants.csv",
      :invoices      => "./data/invoices.csv",
      :invoice_items => "./data/invoice_items.csv",
      :transactions  => "./data/transactions.csv",
      :customers     => "./data/customers.csv"
      })
      assert_instance_of Customer, se.customers.all.first
      assert_equal 1000, se.customers.all.count
      assert_instance_of Customer, se.customers.all.last
  end

  def test_sales_engine_knows_about_find_by_name_in_merchant_repo
    se = SalesEngine.from_csv({
    :items         => "./data/items.csv",
    :merchants     => "./data/merchants.csv",
    :invoices      => "./data/invoices.csv",
    :invoice_items => "./data/invoice_items.csv",
    :transactions  => "./data/transactions.csv",
    :customers     => "./data/customers.csv"
    })
    merchant = se.merchants.find_by_name("Shopin1901")
    assert_equal "Shopin1901", merchant.name
  end

  def test_sales_engine_knows_about_find_by_name_in_item_repo
    se = SalesEngine.from_csv({
    :items         => "./data/items.csv",
    :merchants     => "./data/merchants.csv",
    :invoices      => "./data/invoices.csv",
    :invoice_items => "./data/invoice_items.csv",
    :transactions  => "./data/transactions.csv",
    :customers     => "./data/customers.csv"
    })
    item = se.items.find_by_name("Glitter scrabble frames")
    assert_equal "Glitter scrabble frames", item.name
  end

  def test_sale_engine_has_established_relationship_with_merchant_and_merchant_items
    se = SalesEngine.from_csv({
    :items         => "./data/items.csv",
    :merchants     => "./data/merchants.csv",
    :invoices      => "./data/invoices.csv",
    :invoice_items => "./data/invoice_items.csv",
    :transactions  => "./data/transactions.csv",
    :customers     => "./data/customers.csv"
    })
    merchant = se.merchants.find_by_id(12334105)
    assert_instance_of Item, merchant.items.first
    assert_equal 3, merchant.items.count
  end

  def test_sales_engine_has_relationship_with_merchant_from_item_id
    se = SalesEngine.from_csv({
    :items         => "./data/items.csv",
    :merchants     => "./data/merchants.csv",
    :invoices      => "./data/invoices.csv",
    :invoice_items => "./data/invoice_items.csv",
    :transactions  => "./data/transactions.csv",
    :customers     => "./data/customers.csv"
    })
    item = se.items.find_by_id(263395617)
    assert_instance_of Merchant, item.merchant
  end

  def test_sales_engine_has_relationship_with_invoices
    se = SalesEngine.from_csv({
    :items         => "./data/items.csv",
    :merchants     => "./data/merchants.csv",
    :invoices      => "./data/invoices.csv",
    :invoice_items => "./data/invoice_items.csv",
    :transactions  => "./data/transactions.csv",
    :customers     => "./data/customers.csv"
    })
    merchant = se.merchants.find_by_id(12334105)
    assert_equal 10, merchant.invoices.count
  end

  def test_sales_engine_has_relationship_with_merchant_from_invoice_id
    se = SalesEngine.from_csv({
    :items         => "./data/items.csv",
    :merchants     => "./data/merchants.csv",
    :invoices      => "./data/invoices.csv",
    :invoice_items => "./data/invoice_items.csv",
    :transactions  => "./data/transactions.csv",
    :customers     => "./data/customers.csv"
    })
    invoice = se.invoices.find_by_id(10)
    assert_instance_of Merchant, invoice.merchant
  end

  def test_sales_engine_has_relationship_with_invoice_items
    se = SalesEngine.from_csv({
    :items         => "./data/items.csv",
    :merchants     => "./data/merchants.csv",
    :invoices      => "./data/invoices.csv",
    :invoice_items => "./data/invoice_items.csv",
    :transactions  => "./data/transactions.csv",
    :customers     => "./data/customers.csv"
    })
    assert_instance_of InvoiceItem, se.invoice_items.find_by_id(6)
  end

  def test_sales_engine_has_relationship_with_transactions
    se = SalesEngine.from_csv({
    :items         => "./data/items.csv",
    :merchants     => "./data/merchants.csv",
    :invoices      => "./data/invoices.csv",
    :invoice_items => "./data/invoice_items.csv",
    :transactions  => "./data/transactions.csv",
    :customers     => "./data/customers.csv"
    })
    assert_instance_of Transaction, se.transactions.find_by_id(1)
  end

  def test_sales_engine_has_relationship_with_customers
    se = SalesEngine.from_csv({
    :items         => "./data/items.csv",
    :merchants     => "./data/merchants.csv",
    :invoices      => "./data/invoices.csv",
    :invoice_items => "./data/invoice_items.csv",
    :transactions  => "./data/transactions.csv",
    :customers     => "./data/customers.csv"
    })
    assert_instance_of Customer, se.customers.find_by_id(5)
  end

  def test_sales_engine_can_find_invoice_id_and_access_items_transactions_and_customer
    se = SalesEngine.from_csv({
    :items         => "./data/items.csv",
    :merchants     => "./data/merchants.csv",
    :invoices      => "./data/invoices.csv",
    :invoice_items => "./data/invoice_items.csv",
    :transactions  => "./data/transactions.csv",
    :customers     => "./data/customers.csv"
    })
    invoice = se.invoices.find_by_id(20)
    assert_equal 5, invoice.items.count
    assert_equal 3, invoice.transactions.count
    assert_equal 5, invoice.customer.id
  end

  def test_sales_engine_can_find_transaction_id_and_access_invoice
    se = SalesEngine.from_csv({
    :items         => "./data/items.csv",
    :merchants     => "./data/merchants.csv",
    :invoices      => "./data/invoices.csv",
    :invoice_items => "./data/invoice_items.csv",
    :transactions  => "./data/transactions.csv",
    :customers     => "./data/customers.csv"
    })
    transaction = se.transactions.find_by_id(40)
    assert_instance_of Invoice, transaction.invoice
  end

  def test_sales_engine_can_find_merchant_by_id_and_access_customers
    se = SalesEngine.from_csv({
    :items         => "./data/items.csv",
    :merchants     => "./data/merchants.csv",
    :invoices      => "./data/invoices.csv",
    :invoice_items => "./data/invoice_items.csv",
    :transactions  => "./data/transactions.csv",
    :customers     => "./data/customers.csv"
    })
    merchant = se.merchants.find_by_id(12334135)
    assert_equal 12, merchant.customers.count
  end

  def test_sales_engine_can_find_customer_by_id_and_access_merchants
    se = SalesEngine.from_csv({
    :items         => "./data/items.csv",
    :merchants     => "./data/merchants.csv",
    :invoices      => "./data/invoices.csv",
    :invoice_items => "./data/invoice_items.csv",
    :transactions  => "./data/transactions.csv",
    :customers     => "./data/customers.csv"
    })
    customer = se.customers.find_by_id(10)
    assert_equal 8, customer.merchants.count
  end

  def test_invoice_can_check_if_transaction_has_been_paid_in_full
    se = SalesEngine.from_csv({
    :items         => "./data/items.csv",
    :merchants     => "./data/merchants.csv",
    :invoices      => "./data/invoices.csv",
    :invoice_items => "./data/invoice_items.csv",
    :transactions  => "./data/transactions.csv",
    :customers     => "./data/customers.csv"
    })
    assert se.invoices.find_by_id(1).is_paid_in_full?
  end

  def test_sales_engine_can_check_total_for_invoice_items
    se = SalesEngine.from_csv({
      :items         => "./data/items.csv",
      :merchants     => "./data/merchants.csv",
      :invoices      => "./data/invoices.csv",
      :invoice_items => "./data/invoice_items.csv",
      :transactions  => "./data/transactions.csv",
      :customers     => "./data/customers.csv"
      })
    assert_equal BigDecimal.new('0.2106777E5',18), se.invoices.all.first.total
  end
end
