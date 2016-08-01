require './test/test_helper'
require './lib/sales_engine'

class SalesEngineTest < Minitest::Test
##################
# Accessor Methods
##################
  def test_merchants_returns_a_merchant_repo
    sales_engine = SalesEngine.from_csv({merchants: './data/support/merchant_support.csv'})
    assert_instance_of MerchantsRepo, sales_engine.merchants
  end

  def test_items_returns_an_item_repo
    sales_engine = SalesEngine.from_csv({items: './data/support/items_support.csv'})
    assert_instance_of ItemRepo, sales_engine.items
  end

  def test_invoices_returns_an_invoice_repo
    sales_engine = SalesEngine.from_csv({invoices: './data/support/invoices_support.csv'})
    assert_instance_of InvoiceRepo, sales_engine.invoices
  end

  def test_transactions_returns_a_transactions_repo
    sales_engine = SalesEngine.from_csv({transactions: './data/support/transactions_support.csv'})
    assert_instance_of TransactionRepo, sales_engine.transactions
  end

  def test_customers_returns_a_customer_repo
    sales_engine = SalesEngine.from_csv({customers: './data/support/customer_support.csv'})
    assert_instance_of CustomerRepo, sales_engine.customers
  end

  def test_invoice_items_returns_an_invoice_items_repo
    sales_engine = SalesEngine.from_csv({invoice_items: './data/support/invoice_items_support.csv'})
    assert_instance_of InvoiceItemRepo, sales_engine.invoice_items
  end
###############
# Query methods
###############
  def test_it_finds_merchants
      sales_engine = SalesEngine.from_csv({merchants: './data/support/merchant_support.csv'})

      assert_equal "Candisart", sales_engine.find_merchant_by_id(12334112).name
      refute sales_engine.find_merchant_by_id(0)
  end

  def test_it_finds_items_by_merchant
    sales_engine = SalesEngine.from_csv({items: './data/support/items_support.csv'})

    assert_equal 1, sales_engine.find_all_items_by_merchant_id(12334141).count
  end

  def test_it_finds_invoices_by_merchant
    sales_engine = SalesEngine.from_csv({invoices: './data/support/invoices_support.csv'})

    assert_equal 1, sales_engine.find_all_invoices_by_merchant_id(12335938).count
  end

  def test_it_finds_invoices_items_by_invoice
    sales_engine = SalesEngine.from_csv({invoice_items: './data/support/invoice_items_support.csv'})

    assert_equal 8, sales_engine.find_all_invoice_items_by_invoice_id(1).count
  end

  def test_it_finds_items_by_invoice
    sales_engine = SalesEngine.from_csv({invoice_items: './data/support/invoice_items_support.csv',
      items: './data/support/items_support.csv'})

    assert_equal 8, sales_engine.find_all_items_by_invoice_id(1).count
  end

  def test_it_finds_transactions_by_invoice
    sales_engine = SalesEngine.from_csv({transactions: './data/support/transactions_support.csv'})

    assert_equal 1, sales_engine.find_all_transactions_by_invoice_id(2179).count
  end

  def test_it_finds_all_customers_who_worked_with_a_merchant
    sales_engine = SalesEngine.from_csv({invoices: './data/support/invoices_support.csv',
        customers: './data/support/customer_support.csv'})
    sales_engine.invoices
    sales_engine.customers
    assert_equal 1, sales_engine.find_all_customers_by_merchant_id(12334194).count
  end
end
