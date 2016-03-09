gem 'minitest', '~> 5.2'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/invoice'
require_relative '../lib/invoice_repository'
require_relative '../lib/sales_engine'


class InvoiceClassTest < Minitest::Test

  def setup
    @sales_engine = SalesEngine.from_csv({
      :items     => 'data/items.csv',
      :merchants => 'data/merchants.csv',
      :invoices => 'data/invoices.csv',
      :invoice_items => 'data/invoice_items.csv',
      :transactions => 'data/transactions.csv',
      :customers => 'data/customers.csv'
    })

    @invoice_one = Invoice.new(@sales_engine, {:id => "1",
                            :customer_id => "1",
                            :merchant_id => "12335938",
                            :status => "pending",
                            :created_at => "2009-02-07",
                            :updated_at => "2014-03-15"})

    @invoice_two = Invoice.new(@sales_engine, {:id => "9",
                            :customer_id => "2",
                            :merchant_id => "12336965",
                            :status => "shipped",
                            :created_at => "2003-03-07",
                            :updated_at => "2008-10-09"})

  end

  def test_an_invoice_can_be_instantiated
    assert Invoice.new(SalesEngine.new,{})
    assert @invoice_one
  end

  def test_an_invoice_can_return_its_id
    assert_equal 1, @invoice_one.id
    assert_equal nil, Invoice.new(SalesEngine.new,{}).id
  end

  def test_an_invoice_can_return_its_customer_id
    assert_equal 1, @invoice_one.customer_id
    assert_equal nil, Invoice.new(SalesEngine.new,{}).customer_id

  end

  def test_an_invoice_can_return_its_merchant_id
    assert_equal 12335938, @invoice_one.merchant_id
    assert_equal nil, Invoice.new(SalesEngine.new,{}).merchant_id

  end

  def test_an_invoice_can_return_its_status
    assert_equal :pending, @invoice_one.status
    assert_equal nil, Invoice.new(SalesEngine.new,{}).status
  end

  def test_an_invoice_can_return_the_time_it_was_created_and_updated
    assert_equal Time.new(2009, 02, 07), @invoice_one.created_at
    assert_equal Time.new(2014, 03, 15), @invoice_one.updated_at
  end

  def test_all_invoice_items_can_found_by_invoice_id
    assert_equal 263519844, @invoice_one.items.first.id
    assert_equal [263519844, 263454779, 263451719, 263542298, 263515158, 263539664, 263563764, 263432817], @invoice_one.items.map { |item| item.id}
  end

  def test_all_transactions_can_be_found_by_invoice_id
    assert_equal 2650, @invoice_one.transactions.first.id
    assert_equal 4351, @invoice_one.transactions.last.id
  end

  def test_customer_can_by_found_by_invoice_id
    assert_equal 1, @invoice_one.id
    assert_equal 1, @invoice_one.customer.id
    assert_equal 9, @invoice_two.id
    assert_equal 2, @invoice_two.customer.id
  end

  def test_can_determine_if_invoice_is_paid_in_full
    assert @invoice_one.is_paid_in_full?
    refute @invoice_two.is_paid_in_full?
  end

  def test_can_calculate_total_dollar_amount_for_invoices_paid_in_full
    assert_equal BigDecimal, @invoice_one.total.class
    assert_equal 21067.77, @invoice_one.total.to_f
    assert_equal 0, @invoice_two.total
  end

  def test_can_verify_if_invoice_has_any_failed_transactions?
    assert @invoice_two.any_failed_transactions?
    refute @invoice_one.any_failed_transactions?
  end
end
