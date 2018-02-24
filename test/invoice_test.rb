require_relative 'test_helper'
require_relative '../lib/invoice'
require_relative '../lib/sales_engine'
require 'time'

class InvoiceTest < Minitest::Test

  def setup
    data = {
      id:           6,
      customer_id:  7,
      merchant_id:  8,
      status:       "pending",
      created_at:   "2018-02-02 14:37:20 -0700",
      updated_at:   "2018-02-02 14:37:20 -0700"}
    @invoice = Invoice.new(data)
  end

  def test_if_it_exists
    assert_instance_of Invoice, @invoice
  end

  def test_if_it_has_attributes
    assert_equal 6, @invoice.id
    assert_equal 7, @invoice.customer_id
    assert_equal 8, @invoice.merchant_id
    assert_equal :pending, @invoice.status
    assert @invoice.created_at.class == Time
    assert @invoice.updated_at.class == Time
  end

  def test_if_it_returns_the_merchant_for_an_invoice
    data = {
      :items          => "./test/fixtures/items_sample.csv",
      :merchants      => "./test/fixtures/merchants_sample.csv",
      :invoices       => "./test/fixtures/invoices_sample.csv",
      :invoice_items  => "./test/fixtures/invoice_items_sample.csv",
      :transactions   => "./test/fixtures/transactions_sample.csv",
      :customers      => "./test/fixtures/customers_sample.csv"
        }
    sales_engine = SalesEngine.new(data)
    id = 641
    invoice = sales_engine.invoices.find_by_id(id)

    assert invoice.id == id
    assert invoice.merchant.name == "jejum"
    assert invoice.merchant.class == Merchant
  end

  def test_if_it_returns_all_items_for_an_invoice
    data = {
      :items          => "./test/fixtures/items_sample.csv",
      :merchants      => "./test/fixtures/merchants_sample.csv",
      :invoices       => "./test/fixtures/invoices_sample.csv",
      :invoice_items  => "./test/fixtures/invoice_items_sample.csv",
      :transactions   => "./test/fixtures/transactions_sample.csv",
      :customers      => "./test/fixtures/customers_sample.csv"
        }
    sales_engine = SalesEngine.new(data)
    id = 819
    invoice = sales_engine.invoices.find_by_id(id)

    assert invoice.id == id
    assert_instance_of Item, invoice.items.first
    assert invoice.items.first.class == Item
    assert invoice.items.first.name == "bracciale rigido margherite"
    assert invoice.items.first.id == 263415463
    assert invoice.items.first.merchant_id == 12334228
  end

  def test_if_it_returns_all_transactions_for_an_invoice
    data = {
      :items          => "./test/fixtures/items_sample.csv",
      :merchants      => "./test/fixtures/merchants_sample.csv",
      :invoices       => "./test/fixtures/invoices_sample.csv",
      :invoice_items  => "./test/fixtures/invoice_items_sample.csv",
      :transactions   => "./test/fixtures/transactions_sample.csv",
      :customers      => "./test/fixtures/customers_sample.csv"
        }
    sales_engine = SalesEngine.new(data)
    id = 2179
    invoice = sales_engine.invoices.find_by_id(id)

    assert invoice.id == id
    assert_instance_of Transaction, invoice.transactions.first
    assert invoice.transactions.first.class == Transaction
    assert invoice.transactions.first.credit_card_number == 4068631943231473
    assert invoice.transactions.first.invoice_id == 2179
  end

  def test_if_it_returns_customer_based_on_customer_id
    data = {
      :items          => "./test/fixtures/items_sample.csv",
      :merchants      => "./test/fixtures/merchants_sample.csv",
      :invoices       => "./test/fixtures/invoices_sample.csv",
      :invoice_items  => "./test/fixtures/invoice_items_sample.csv",
      :transactions   => "./test/fixtures/transactions_sample.csv",
      :customers      => "./test/fixtures/customers_sample.csv"
        }
    sales_engine = SalesEngine.new(data)
    id = 1053
    invoice = sales_engine.invoices.find_by_id(id)

    assert invoice.id == id
    assert_instance_of Customer, invoice.customer
    assert invoice.customer.class == Customer
    assert invoice.customer.first_name == "Oda"
    assert invoice.customer.last_name == "Schinner"
  end

end
