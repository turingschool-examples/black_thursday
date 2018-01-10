require "./test/test_helper"
require "./lib/sales_engine"

class SalesEngineTest < MiniTest::Test

  def setup
    @sales_engine = SalesEngine.from_csv({
      :items      => "./test/fixtures/items_fixtures.csv",
      :merchants  => "./test/fixtures/merchants_fixtures.csv",
      :invoices   => "./test/fixtures/invoices_fixtures.csv",
      :invoice_items => "./test/fixtures/invoice_items_fixtures.csv",
      :transactions => "./test/fixtures/transactions_fixtures.csv",
      :customers => "./test/fixtures/customers_fixtures.csv"
    })
  end

  def test_self_items_returns_instance_of_item_repository
    assert_instance_of ItemRepository, @sales_engine.items
  end

  def test_self_merchants_returns_instance_of_merchant_repository
    assert_instance_of MerchantRepository, @sales_engine.merchants
  end

  def test_self_all_items_returns_an_array_of_items
    assert_equal Array, @sales_engine.all_items.class

    assert_equal Item, @sales_engine.all_items[0].class
  end

  def test_self_all_merchants_returns_an_array_of_merchants
    assert_equal Array, @sales_engine.all_merchants.class

    assert_equal Merchant, @sales_engine.all_merchants[0].class
  end

  def test_invoices_returns_instance_of_invoice_repository
    assert_instance_of InvoiceRepository, @sales_engine.invoices
  end

  def test_all_invoices_returns_an_array_of_invoices
    assert_equal Array, @sales_engine.all_invoices.class

    assert_equal Invoice, @sales_engine.all_invoices[0].class
  end

  def test_transactions_returns_instance_of_transaction_repository
    assert_instance_of TransactionRepository, @sales_engine.transactions
  end

  def test_customers_returns_instance_of_customer_repository
    assert_instance_of CustomerRepository, @sales_engine.customers
  end

  def test_invoice_items_returns_instance_of_invoice_item_repository
    assert_instance_of InvoiceItemRepository, @sales_engine.invoice_items
  end

  def test_assign_item_count_assigns_an_item_count_to_merchant
    assert_equal 45, @sales_engine.assign_item_count(12335519, 45)
    assert_equal 45, @sales_engine.merchants.find_by_id(12335519).item_count
  end

  def test_assign_total_revenue_assigns_total_revenue_to_merchant
    assert_equal 75404, @sales_engine.assign_total_revenue(12335519, 75404)
    assert_equal 75404, @sales_engine.merchants.find_by_id(12335519).total_revenue
  end

  def test_find_merchants_by_id_returns_instance_of_merchant
    assert_instance_of Merchant, @sales_engine.find_merchant_by_id(12335519)
    assert_equal "TIGHTpinch", @sales_engine.find_merchant_by_id(12335519).name
  end

  def test_items_by_id_returns_items_by_merchant_id
    assert_instance_of Item, @sales_engine.items_by_id(12335519).first
    assert_equal 1, @sales_engine.items_by_id(12335519).count
  end

  def test_find_invoice_by_merchant_id_returns_array_of_invoices
    assert_instance_of Invoice, @sales_engine.find_invoice_by_merchant_id(12335519).first
    assert_equal 11, @sales_engine.find_invoice_by_merchant_id(12335519).count
  end

  def test_find_cost_by_invoice_returns_invoice_items_by_invoice_id
    assert_instance_of InvoiceItem, @sales_engine.find_cost_by_invoice_id(724).first
    assert_equal 6, @sales_engine.find_cost_by_invoice_id(724).count
  end

  def test_find_transactions_by_invoice_id_returns_array_of_transactions
    assert_instance_of Transaction, @sales_engine.find_transactions_by_invoice_id(3675).first
    assert_equal 1, @sales_engine.find_transactions_by_invoice_id(3675).count
  end

  def test_find_customer_by_customer_id_returns_array_of_customers
    assert_instance_of Customer, @sales_engine.find_customer_by_customer_id(732)
    assert_equal "Jermey", @sales_engine.find_customer_by_customer_id(732).first_name
  end

  def test_find_invoice_by_invoice_id_returns_instance_of_invoice
    assert_instance_of Invoice, @sales_engine.find_invoice_by_invoice_id(2565)
    assert_equal 2565, @sales_engine.find_invoice_by_invoice_id(2565).id
  end

  def test_find_all_merchants_by_customer_id_returns_array_of_invoices
    assert_instance_of Merchant, @sales_engine.find_all_merchants_by_customer_id(732).first
    assert_equal 1, @sales_engine.find_all_merchants_by_customer_id(732).count
  end

  def test_find_invoices_by_date_returns_array_of_invoices
    date = Time.parse("2007-09-24")
    assert_instance_of Invoice, @sales_engine.find_invoices_by_date(date).first
    assert_equal 1, @sales_engine.find_invoices_by_date(date).count
  end

  def test_find_pending_invoices_returns_array_of_invoices
    assert_instance_of Invoice, @sales_engine.find_pending_invoices.first
    assert_equal 116, @sales_engine.find_pending_invoices.count
  end

  def test_find_item_by_id_returns_instance_of_item
    assert_instance_of Item, @sales_engine.find_item_by_id(263421633)
    assert_equal 263421633, @sales_engine.find_item_by_id(263421633).id
  end
end
