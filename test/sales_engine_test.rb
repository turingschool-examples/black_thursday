require './test/test_helper'
require './lib/sales_engine.rb'
require 'pry'

class SalesEngineTest < Minitest::Test

  def test_it_exists
    se = SalesEngine.from_csv({:items => './data/items_short.csv',
                               :merchants => './data/merchants_short.csv',
                               :invoices => './data/invoices_short.csv',
                               :invoice_items => './data/invoice_items_short.csv',
                               :transactions => './data/transactions_short.csv',
                               :customers => './data/customers_short.csv'})

    assert_instance_of SalesEngine, se
  end

  def test_it_creates_an_item_repository
    se = SalesEngine.from_csv({:items => './data/items_short.csv',
                               :merchants => './data/merchants_short.csv',
                               :invoices => './data/invoices_short.csv',
                               :invoice_items => './data/invoice_items_short.csv',
                               :transactions => './data/transactions_short.csv',
                               :customers => './data/customers_short.csv'})

    items = se.items

    assert_instance_of ItemRepository, items
  end

  def test_it_creates_a_merchant_repository
    se = SalesEngine.from_csv({:items => './data/items_short.csv',
                               :merchants => './data/merchants_short.csv',
                               :invoices => './data/invoices_short.csv',
                               :invoice_items => './data/invoice_items_short.csv',
                               :transactions => './data/transactions_short.csv',
                               :customers => './data/customers_short.csv'})

    merchants = se.merchants

    assert_instance_of MerchantRepository, merchants
  end

  def test_merchant_repository_can_find_all_merchants
    se = SalesEngine.from_csv({:items => './data/items.csv',
                               :merchants => './data/merchants.csv',
                               :invoices => './data/invoices.csv',
                               :invoice_items => './data/invoice_items.csv',
                               :transactions => './data/transactions.csv',
                               :customers => './data/customers.csv'})

    mr = se.merchants
    merchant = mr.all

    assert_equal 475, merchant.length
    assert_equal Array, merchant.class
  end

  def test_item_repository_can_find_all_items
    se = SalesEngine.from_csv({:items => './data/items.csv',
                               :merchants => './data/merchants.csv',
                               :invoices => './data/invoices.csv',
                               :invoice_items => './data/invoice_items.csv',
                               :transactions => './data/transactions.csv',
                               :customers => './data/customers.csv'})

    ir = se.items
    item = ir.all

    assert_equal 1367, item.length
    assert_equal Array, item.class
  end

  def test_can_retrieve_items_from_items_repo_with_merchant_id
    se = SalesEngine.from_csv({:items => './data/items_short.csv',
                               :merchants => './data/merchants_short.csv',
                               :invoices => './data/invoices_short.csv',
                               :invoice_items => './data/invoice_items_short.csv',
                               :transactions => './data/transactions_short.csv',
                               :customers => './data/customers_short.csv'})

    target = se.pass_merchant_id(12334105)

    assert_equal 1, target.count
    assert_equal Array, target.class
  end

  def test_it_can_retrieve_items_from_items_with_merchant_id
    se = SalesEngine.from_csv({:items => './data/items_short.csv',
                               :merchants => './data/merchants_short.csv',
                               :invoices => './data/invoices_short.csv',
                               :invoice_items => './data/invoice_items_short.csv',
                               :transactions => './data/transactions_short.csv',
                               :customers => './data/customers_short.csv'})

    merchant = se.merchants.find_by_id(12334105)

    assert_equal 1, merchant.items.count
    assert_equal Array, merchant.items.class
  end

  def test_can_retrieve_merchant_from_merchant_repo_with_item_id
    se = SalesEngine.from_csv({:items => './data/items_short.csv',
                               :merchants => './data/merchants_short.csv',
                               :invoices => './data/invoices_short.csv',
                               :invoice_items => './data/invoice_items_short.csv',
                               :transactions => './data/transactions_short.csv',
                               :customers => './data/customers_short.csv'})

    target = se.pass_items_merchant_id(12334105)

    assert_equal "Shopin1901", target.name
  end

  def test_it_can_retrieve_merchant_with_merchant_id_from_item
    se = SalesEngine.from_csv({:items => './data/items_short.csv',
                               :merchants => './data/merchants_short.csv',
                               :invoices => './data/invoices_short.csv',
                               :invoice_items => './data/invoice_items_short.csv',
                               :transactions => './data/transactions_short.csv',
                               :customers => './data/customers_short.csv'})

    item = se.items.find_by_id(263395237)

    assert_equal "jejum", item.merchant.name
  end

  def test_it_creates_a_invoice_repository
    se = SalesEngine.from_csv({:items => './data/items_short.csv',
                               :merchants => './data/merchants_short.csv',
                               :invoices => './data/invoices_short.csv',
                               :invoice_items => './data/invoice_items_short.csv',
                               :transactions => './data/transactions_short.csv',
                               :customers => './data/customers_short.csv'})

    inr = se.invoices
    assert_instance_of InvoiceRepository, inr
  end

  def test_invoice_repository_can_find_all_invoices
    se = SalesEngine.from_csv({:items => './data/items_short.csv',
                               :merchants => './data/merchants_short.csv',
                               :invoices => './data/invoices_short.csv',
                               :invoice_items => './data/invoice_items_short.csv',
                               :transactions => './data/transactions_short.csv',
                               :customers => './data/customers_short.csv'})

    inr = se.invoices
    invoice = inr.all

    assert_equal 13, invoice.length
    assert_equal Array, invoice.class
  end

  def test_can_retrieve_invoices_from_invoice_repo_with_merchant_id
    se = SalesEngine.from_csv({:items => './data/items_short.csv',
                               :merchants => './data/merchants_short.csv',
                               :invoices => './data/invoices_short.csv',
                               :invoice_items => './data/invoice_items_short.csv',
                               :transactions => './data/transactions_short.csv',
                               :customers => './data/customers_short.csv'})

    merchant = se.merchants.find_by_id(12334105)
    target = merchant.invoices

    assert_equal 1, target.count
    assert_equal Array, target.class
  end

  def test_it_can_retrieve_merchant_with_invoice_id
    se = SalesEngine.from_csv({:items => './data/items_short.csv',
                               :merchants => './data/merchants_short.csv',
                               :invoices => './data/invoices_short.csv',
                               :invoice_items => './data/invoice_items_short.csv',
                               :transactions => './data/transactions_short.csv',
                               :customers => './data/customers_short.csv'})

    invoice = se.invoices.find_by_id(2)
    target = invoice.merchant

    assert_equal "CenTexCustomCoatings", target.name
  end

  def test_it_creates_an_invoice_item_repository
    se = SalesEngine.from_csv({:items => './data/items_short.csv',
                               :merchants => './data/merchants_short.csv',
                               :invoices => './data/invoices_short.csv',
                               :invoice_items => './data/invoice_items_short.csv',
                               :transactions => './data/transactions_short.csv',
                               :customers => './data/customers_short.csv'})

    iir = se.invoice_items
    assert_instance_of InvoiceItemRepository, iir
  end

  def test_invoice_item_repository_can_find_all_invoice_items
    se = SalesEngine.from_csv({:items => './data/items_short.csv',
                               :merchants => './data/merchants_short.csv',
                               :invoices => './data/invoices_short.csv',
                               :invoice_items => './data/invoice_items_short.csv',
                               :transactions => './data/transactions_short.csv',
                               :customers => './data/customers_short.csv'})

    iir = se.invoice_items
    invoice_items = iir.all

    assert_equal 10, invoice_items.length
    assert_equal Array, invoice_items.class
  end

  def test_it_creates_a_transaction_repository
    se = SalesEngine.from_csv({:items => './data/items_short.csv',
                               :merchants => './data/merchants_short.csv',
                               :invoices => './data/invoices_short.csv',
                               :invoice_items => './data/invoice_items_short.csv',
                               :transactions => './data/transactions_short.csv',
                               :customers => './data/customers_short.csv'})

    tr = se.transactions
    assert_instance_of TransactionRepository, tr
  end

  def test_transaction_repository_can_find_all_transactions
    se = SalesEngine.from_csv({:items => './data/items_short.csv',
                               :merchants => './data/merchants_short.csv',
                               :invoices => './data/invoices_short.csv',
                               :invoice_items => './data/invoice_items_short.csv',
                               :transactions => './data/transactions_short.csv',
                               :customers => './data/customers_short.csv'})

    tr = se.transactions
    transactions = tr.all

    assert_equal 10, transactions.length
    assert_equal Array, transactions.class
  end

  def test_it_creates_a_customer_repository
    se = SalesEngine.from_csv({:items => './data/items_short.csv',
                               :merchants => './data/merchants_short.csv',
                               :invoices => './data/invoices_short.csv',
                               :invoice_items => './data/invoice_items_short.csv',
                               :transactions => './data/transactions_short.csv',
                               :customers => './data/customers_short.csv'})

    cr = se.customers
    assert_instance_of CustomerRepository, cr
  end

  def test_customer_repository_can_find_all_customers
    se = SalesEngine.from_csv({:items => './data/items_short.csv',
                               :merchants => './data/merchants_short.csv',
                               :invoices => './data/invoices_short.csv',
                               :invoice_items => './data/invoice_items_short.csv',
                               :transactions => './data/transactions_short.csv',
                               :customers => './data/customers_short.csv'})

    cr = se.customers
    customers = cr.all

    assert_equal 11, customers.length
    assert_equal Array, customers.class
  end

  def test_it_can_retrieve_items_with_invoice_id
    se = SalesEngine.from_csv({:items => './data/items.csv',
                               :merchants => './data/merchants.csv',
                               :invoices => './data/invoices.csv',
                               :invoice_items => './data/invoice_items.csv',
                               :transactions => './data/transactions.csv',
                               :customers => './data/customers.csv'})

    invoice = se.invoices.find_by_id(2)

    assert_equal 263529264, invoice.items[0].id
    assert_equal 4, invoice.items.count
  end

  def test_it_can_retrieve_transactions_with_invoice_id
    se = SalesEngine.from_csv({:items => './data/items_short.csv',
                               :merchants => './data/merchants_short.csv',
                               :invoices => './data/invoices_short.csv',
                               :invoice_items => './data/invoice_items_short.csv',
                               :transactions => './data/transactions_short.csv',
                               :customers => './data/customers_short.csv'})

    invoice = se.invoices.find_by_id(46)

    assert_equal 2, invoice.transactions[0].id
    assert_equal 1, invoice.transactions.count
  end

  def test_it_can_retrieve_customers_with_invoice_id
    se = SalesEngine.from_csv({:items => './data/items_short.csv',
                               :merchants => './data/merchants_short.csv',
                               :invoices => './data/invoices_short.csv',
                               :invoice_items => './data/invoice_items_short.csv',
                               :transactions => './data/transactions_short.csv',
                               :customers => './data/customers_short.csv'})

    invoice = se.invoices.find_by_id(9)

    assert_equal "Cecelia", invoice.customer.first_name
  end

  def test_it_can_retrieve_invoices_with_transaction_id
    se = SalesEngine.from_csv({:items => './data/items_short.csv',
                               :merchants => './data/merchants_short.csv',
                               :invoices => './data/invoices_short.csv',
                               :invoice_items => './data/invoice_items_short.csv',
                               :transactions => './data/transactions_short.csv',
                               :customers => './data/customers_short.csv'})

    transaction = se.transactions.find_by_id(2)

    assert_equal 10, transaction.invoice.customer_id
  end

  def test_it_can_retrieve_customers_with_merchant_id
    se = SalesEngine.from_csv({:items => './data/items_short.csv',
                               :merchants => './data/merchants_short.csv',
                               :invoices => './data/invoices_short.csv',
                               :invoice_items => './data/invoice_items_short.csv',
                               :transactions => './data/transactions_short.csv',
                               :customers => './data/customers_short.csv'})

    merchant = se.merchants.find_by_id(12334105)

    assert_equal 1, merchant.customers.count
    assert_equal "Casimer", merchant.customers[0].first_name
  end

  def test_it_can_retrieve_merchants_with_customer_id
    se = SalesEngine.from_csv({:items => './data/items_short.csv',
                               :merchants => './data/merchants_short.csv',
                               :invoices => './data/invoices_short.csv',
                               :invoice_items => './data/invoice_items_short.csv',
                               :transactions => './data/transactions_short.csv',
                               :customers => './data/customers_short.csv'})

    customer = se.customers.find_by_id(2)

    assert_equal 2, customer.merchants.count
    assert_equal "JewelleAccessories", customer.merchants[0].name
  end

  def test_it_knows_if_invoice_is_paid_in_full
    se = SalesEngine.from_csv({:items => './data/items_short.csv',
                               :merchants => './data/merchants_short.csv',
                               :invoices => './data/invoices_short.csv',
                               :invoice_items => './data/invoice_items_short.csv',
                               :transactions => './data/transactions_short.csv',
                               :customers => './data/customers_short.csv'})

    invoice = se.invoices.find_by_id(46)
    invoice_2 = se.invoices.find_by_id(1752)

    assert invoice.is_paid_in_full?
    refute invoice_2.is_paid_in_full?
  end
end
