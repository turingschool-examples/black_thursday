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
    assert_instance_of Array, invoice.items
    assert_equal 8, invoice.items.count
    assert_equal 263519844, invoice.items.first.item_id
  end

  def test_it_can_find_all_transactions_by_invoice_id
    assert_instance_of Array, invoice.transactions
    assert_equal 1, invoice.transactions.count
    assert_equal 8, invoice.transactions.first.id
  end

  def test_it_can_find_customer_by_invoice_id
    assert_instance_of Customer, invoice.customer
    assert_equal "Ondricka", invoice.customer.last_name
  end

  def test_it_knows_if_invoice_is_paid
    assert invoice.is_paid_in_full?
    invoice2 = se.invoices.find_by_id(1752)
    refute invoice2.is_paid_in_full?
  end

  def test_it_knows_total
    invoice2 = se.invoices.find_by_id(22)
    assert_equal 5289.13, invoice2.total
  end
end
