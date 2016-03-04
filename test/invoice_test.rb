gem 'minitest', '~> 5.2'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/invoice'
require_relative '../lib/invoice_repository'
require_relative '../lib/sales_engine'


class InvoiceClassTest < Minitest::Test

  def setup
    @invoice = Invoice.new(SalesEngine.new, {:id => "234",
                            :customer_id => "1",
                            :merchant_id => "12335938",
                            :status => "pending",
                            :created_at => "2009-02-07",
                            :updated_at => "2014-03-15"})
  end

  def test_an_invoice_can_be_instantiated
    assert Invoice.new(SalesEngine.new,{})
    assert @invoice
  end

  def test_an_invoice_can_return_its_id
    assert_equal 234, @invoice.id
    assert_equal nil, Invoice.new(SalesEngine.new,{}).id
  end

  def test_an_invoice_can_return_its_customer_id
    assert_equal 1, @invoice.customer_id
    assert_equal nil, Invoice.new(SalesEngine.new,{}).customer_id

  end

  def test_an_invoice_can_return_its_merchant_id
    assert_equal 12335938, @invoice.merchant_id
    assert_equal nil, Invoice.new(SalesEngine.new,{}).merchant_id

  end

  def test_an_invoice_can_return_its_status
    assert_equal :pending, @invoice.status
    assert_equal nil, Invoice.new(SalesEngine.new,{}).status
  end

  def test_an_invoice_can_return_the_time_it_was_created_and_updated
    assert_equal Time.new(2009, 02, 07), @invoice.created_at
    assert_equal Time.new(2014, 03, 15), @invoice.updated_at
  end



end
