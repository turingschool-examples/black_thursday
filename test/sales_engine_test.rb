require_relative './test_helper'
require './lib/sales_engine'

class SalesEngineTest < Minitest::Test
  attr_reader :se

  def setup

    @se = SalesEngine.from_csv({
      :items => "./test/fixture/item_truncated.csv",
      :merchants => './test/fixture/merchants_truncated.csv',
      :invoices => './test/fixture/invoice_truncated.csv',
      :customers => './test/fixture/customer_truncated.csv',
      :invoice_items => './test/fixture/invoice_item_truncated.csv',
      :transactions => './test/fixture/transactions_truncated.csv'
    })
  end

  def test_repositories_populated_after_load

    assert_instance_of SalesEngine, se
    assert_instance_of ItemRepository, se.items
    assert_equal 8, se.items.all.count
    assert_instance_of MerchantRepository, se.merchants
    assert_equal 5, se.merchants.all.count
    assert_instance_of InvoiceRepository, se.invoices
    assert_equal 34, se.invoices.all.count
    assert_instance_of CustomerRepository, se.customers
    assert_equal 20, se.customers.all.count
    assert_instance_of TransactionRepository, se.transactions
    assert_equal 23, se.transactions.all.count
  end

  def test_find_items_for_merchant_by_merchant_id
    merchant = se.merchants.find_by_id(12334185)

    assert_equal 4, merchant.items.count
  end

  def test_find_merchant_for_item_by_merchant_id
    item = se.items.find_by_id(263395721)

    assert_equal 'Madewithgitterxx', item.merchant.name
  end

  def test_find_invoices_for_merchant
    merchant = se.merchants.find_by_id(12334185)

    assert_equal 24, merchant.invoices.count
  end

  def test_find_items_for_invoice
    invoice = se.invoices.find_by_id(1495)
    invoice_items = invoice.items

    assert_instance_of Item, invoice_items.first
    assert_equal 6, invoice_items.count
  end

  def test_find_customer_for_invoice
    invoice = se.invoices.find_by_id(1495)
    customer = invoice.customer

    assert_instance_of Customer, customer
    assert_equal "Joey", customer.first_name
  end

  def test_find_transaction_for_invoice
    invoice = se.invoices.find_by_id(1495)
    transactions = invoice.transactions

    assert_instance_of Transaction, transactions.first
    assert_equal 'success', transactions.first.result
  end

  def test_find_invoice_by_id
    transaction = se.transactions.find_by_id(1)
    invoice = transaction.invoice

    assert_instance_of Invoice, invoice
    assert_equal 1495, invoice.id
  end

  def test_find_all_customers_for_merchant
    merchant = se.merchants.find_by_id(12334185)
    customers = merchant.customers

    assert_instance_of Customer, customers.first
    assert_equal 297, customers.first.id
    assert_equal 30, customers.last.id
    assert_equal 18, customers.count
  end

  def test_find_all_merchants_for_customer
    customer = se.customers.find_by_id(297)
    merchants = customer.merchants

    assert_instance_of Merchant, merchants.first
    assert_equal 12334123, merchants.first.id
    assert_equal 12334185, merchants.last.id
    assert_equal 2, merchants.count
  end

  def check_if_invoice_paid_in_full
    invoice_1 = se.invoices.find_by_id(1495)
    invoice_2 = se.invoices.find_by_id(4966)

    assert invoice_1.is_paid_in_full?
    refute invoice_2.is_paid_in_full?
  end


end
