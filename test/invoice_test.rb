require_relative 'test_helper'
require_relative '../lib/invoice'

class InvoiceTest < Minitest::Test 

  attr_reader :invoice

  def setup
    @invoice = Invoice.new({:id => 6,
                            :customer_id => 7,
                            :merchant_id => 12335938,
                            :status => "pending",
                            :created_at => Time.parse("2009-02-07"),
                            :updated_at => Time.parse("2014-03-15")})
  end

  def test_invoice_has_id
    assert_equal 6, invoice.id
  end

  def test_invoice_has_customer_id
    assert_equal 7, invoice.customer_id
  end

  def test_invoice_has_merchant_id
    assert_equal 12335938, invoice.merchant_id
  end

  def test_invoice_has_status
    assert_equal :pending, invoice.status
  end

  def test_invoice_has_created_at_time
    assert_equal 2009, invoice.created_at.year
  end

  def test_invoice_has_updated_at_time
    assert_equal 2014, invoice.updated_at.year
  end
end