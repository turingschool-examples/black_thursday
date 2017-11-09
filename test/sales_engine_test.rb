require_relative 'test_helper'
require_relative '../lib/sales_engine'

class SalesEngineTest < Minitest::Test
  attr_reader :se

  def setup
    @se = SalesEngine.from_csv({:items         => "./data/items.csv",
                                :merchants     => "./data/merchants.csv",
                                :invoices      => "./data/invoices.csv",
                                :invoice_items => "./data/invoice_items.csv",
                                :transactions  => "./data/transactions.csv",
                                :customers     => "./data/customers.csv"
                              })
  end

  def test_it_exists
    assert_instance_of SalesEngine, se
  end

  def test_imports_from_csv
    assert_instance_of ItemRepository, se.items
    assert_instance_of MerchantRepository, se.merchants
  end

  def test_populates_all_array
    assert_instance_of Array, se.items.all
    assert_equal 1367, se.items.all.count
    assert_equal 475, se.merchants.all.count
  end

  def test_it_can_find_by_id

    merchant = se.merchants.find_by_id(12334112)
    assert_equal 1, merchant.items.count
  end

  def test_matches_correct_merchant

    item = se.items.find_by_id(263395237)
    item.merchant

    assert_instance_of Merchant, item.merchant
  end

  def test_can_get_invoices_from_merchant
    merchant = se.merchants.find_by_id(12334159)

    assert_instance_of Array, merchant.invoices
    assert_equal 13, merchant.invoices.count
  end

  def test_can_get_merchant_from_invoice
    invoice = se.invoices.find_by_id(20)

    assert_instance_of Merchant, invoice.merchant
  end

  def test_invoice_communicates_with_items
    invoice = se.invoices.find_by_id(20)

    assert_instance_of Array, invoice.items
  end

  def test_invoice_linked_to_transaction
    invoice = se.invoices.find_by_id(20)

    assert_instance_of Array, invoice.transactions
    assert_instance_of Transaction, invoice.transactions.first
  end

  def test_invoice_linked_to_customer
    invoice = se.invoices.find_by_id(20)

    assert_instance_of Customer, invoice.customer
  end

  def test_transaction_can_be_linked_to_invoice
    transaction = se.transactions.find_by_id(40)

    assert_instance_of Invoice, transaction.invoice
  end

  def test_merchant_linked_to_its_customers
    merchant = se.merchants.find_by_id(12335938)

    assert_instance_of Array, merchant.customers
    assert_instance_of Customer, merchant.customers.first
  end

  def test_customer_is_linked_to_merchants
    customer = se.customers.find_by_id(30)

    assert_instance_of Array, customer.merchants
    assert_instance_of Merchant, customer.merchants.first
  end

  def test_invoice_checks_if_paid_in_full
    invoice = se.invoices.find_by_id(20)

    assert invoice.is_paid_in_full?
  end

  def test_invoice_can_find_total_amount
    invoice = se.invoices.find_by_id(20)

    assert_equal 0.1301863e5, invoice.total
  end

  def test_can_get_fully_paid_invoices_for_customer
    customer = se.customers.find_by_id(30)

    assert_instance_of Array, customer.fully_paid_invoices
    assert_instance_of Invoice, customer.fully_paid_invoices.last
    assert_equal 3, customer.fully_paid_invoices.count
  end

end
