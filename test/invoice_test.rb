require_relative 'test_helper.rb'
require_relative '../lib/invoice'
require_relative '../lib/sales_engine'
require_relative 'sales_engine_methods'

class InvoiceTest < Minitest::Test
  include SalesEngineMethods

  attr_reader :se, :i, :invoice
  def setup
    create_sales_engine
    @i = Invoice.new({
      :id => 25,
      :customer_id => 33,
      :merchant_id => 12335938,
      :status => "pending",
      :created_at => "2007-06-04 21:35:10 UTC",
      :updated_at => "2016-01-11 09:34:06 UTC"
      })
    @invoice = se.invoices.find_by_id(1)
  end

  def test_it_exists
    assert_instance_of Invoice, i
  end

  def test_it_knows_id
    assert_equal 25, i.id
  end

  def test_it_knows_customer_id
    assert_equal 33, i.customer_id
  end

  def test_it_returns_merchant_id
    assert_equal 12335938, i.merchant_id
  end

  def test_it_knows_unit_price
    assert_equal :pending, i.status
  end

  def test_it_knows_what_time_it_was_created
    assert_instance_of Time, i.created_at
    assert_equal 2007, i.created_at.year
  end

  def test_it_knows_what_time_it_was_udpated
    assert_instance_of Time, i.updated_at
    assert_equal 2016, i.updated_at.year
  end

  def test_it_can_find_merchant_based_on_invoice_id
    assert_instance_of Merchant, invoice.merchant
    assert_equal "Shopper", invoice.merchant.name
  end

  def test_it_can_can_find_all_items_based_on_invoice_id
    invoice2 = se.invoices.find_by_id(3715)
    assert_instance_of Array, invoice2.items
    assert_instance_of Item, invoice2.items.first
    assert_equal 2, invoice2.items.count
    assert_equal 263394417, invoice2.items.first.id
  end

  def test_it_can_find_all_invoice_items_based_on_invoice_id
    assert_instance_of Array, invoice.invoice_items
    assert_instance_of InvoiceItem, invoice.invoice_items.first
    assert_equal 6, invoice.invoice_items.count
  end

  def test_it_can_find_all_transactions_by_invoice_id
    assert_instance_of Array, invoice.transactions
    assert_instance_of Transaction, invoice.transactions.first
    assert_equal 1, invoice.transactions.count
    assert_equal 8, invoice.transactions.first.id
  end

  def test_it_can_find_customer_by_invoice_id
    assert_instance_of Customer, invoice.customer
    assert_equal "Ondricka", invoice.customer.last_name
  end

  def test_it_knows_if_invoice_is_paid
    invoice2 = se.invoices.find_by_id(3715)
    refute invoice2.is_paid_in_full?
    invoice3 = se.invoices.find_by_id(1752)
    assert invoice3.is_paid_in_full?
  end

  def test_it_knows_total
    assert_instance_of BigDecimal, invoice.total
    assert_equal 12922.97, invoice.total.to_f
  end
end
