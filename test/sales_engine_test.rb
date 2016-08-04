require './test/test_helper'
require './lib/sales_engine'

class SalesEngineTest < Minitest::Test
  attr_reader :se

  def setup
    @se = SalesEngine.from_csv({
      :items     => "./test/fixtures/items_fixture.csv",
      :merchants => "./test/fixtures/merchants_fixture.csv",
      :invoices  => "./test/fixtures/invoices_fixture.csv",
      :invoice_items => "./test/fixtures/invoice_items_fixture.csv",
      :transactions => "./test/fixtures/transactions_fixture.csv",
      :customers => "./test/fixtures/customers_fixture.csv",

    })
  end

  def test_has_items_and_merchants
    assert_instance_of ItemRepository, se.items
    assert_instance_of MerchantRepository, se.merchants
    assert_instance_of InvoiceRepository, se.invoices
    assert_instance_of TransactionRepository, se.transactions
    assert_instance_of InvoiceItemRepository, se.invoice_items
    assert_instance_of CustomerRepository, se.customers
  end

  def test_finds_merchant_by_merchant_id
    merchant = se.merchants.find_by_id(1000)
    assert_equal merchant, se.find_merchant_by_id(1000)
  end

  def test_find_invoice_by_invoice_id
    invoice = se.invoices.find_by_id(2179)
    assert_equal invoice, se.find_invoice_by_id(2179)
  end

  def test_find_customer_by_customer_id
    customer = se.customers.find_by_id(100)
    assert_equal customer, se.find_customer_by_id(100)
  end

  def test_finds_all_items_by_merchant_id
    items = se.items.find_all_by_merchant_id(1000)
    assert_equal items, se.find_all_items_by_merchant_id(1000)
  end

  def test_finds_all_invoices_by_merchant_id
    invoices = se.invoices.find_all_by_merchant_id(1000)
    assert_equal invoices, se.find_all_invoices_by_merchant_id(1000)
  end

  def test_method_find_all_customers_by_merchant_id
    customers = [200, 600, 700].map { |id| se.customers.find_by_id(id) }
    assert_equal customers, se.find_all_customers_by_merchant_id(1001)
  end

  def test_merchant_accesses_items
    merchant = se.merchants.find_by_id(1000)
    merchants_items = se.find_all_items_by_merchant_id(1000)
    assert_equal merchants_items, merchant.items
  end

  def test_item_accesses_merchant
    item = se.items.find_by_id(1)
    items_merchant = se.find_merchant_by_id(1000)
    assert_equal items_merchant, item.merchant
  end

  def test_customer_accesses_merchants
    customer = se.customers.find_by_id(200)
    customers_merchants = se.find_all_merchants_by_customer_id(200)
    assert_equal customers_merchants, customer.merchants
  end

  def test_method_all_merchants_returns_merchants
    assert_equal se.merchants.all, se.all_merchants
  end

  def test_method_total_merchants_returns_fixnum
    assert_equal se.merchants.all.length, se.total_merchants
  end

  def test_method_find_items_by_invoice_id_returns_items
    items = [4,5].map{ |id| se.items.find_by_id(id) }
    assert_equal items, se.find_items_by_invoice_id(2)
  end

  def test_method_find_invoice_items_by_invoice_id_returns_invoice_items
    invoice_items = se.invoice_items.find_all_by_invoice_id(1)
    assert_equal invoice_items, se.find_invoice_items_by_invoice_id(1)
  end

  def test_method_find_transactions_by_invoice_id_returns_transactions
    transactions = [se.transactions.find_by_id(5)]
    assert_equal transactions, se.find_transactions_by_invoice_id(1)
  end



end
