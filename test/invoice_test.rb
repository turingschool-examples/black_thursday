require_relative './test_helper'
require './lib/invoice'

class InvoiceTest < Minitest::Test
  def test_invoice_accepts_attributes
    invoice = Invoice.new({
      :id => '24680',
      :customer_id => '12345',
      :merchant_id => '54321',
      :status => 'pending',
      :created_at => '2017-10-31',
      :updated_at => '2017-10-30'
      })

    assert_instance_of Invoice, invoice
    assert_equal '24680', invoice.id
    assert_equal '12345', invoice.customer_id
    assert_equal '54321', invoice.merchant_id
    assert_equal 'pending', invoice.status
    assert_equal '2017-10-31', invoice.created_at
    assert_equal '2017-10-30', invoice.updated_at
  end

  def test_invoice_accepts_other_attributes
    invoice = Invoice.new({
      :id => '13579',
      :customer_id => '23456',
      :merchant_id => '65432',
      :status => 'shipped',
      :created_at => '2017-1-31',
      :updated_at => '2017-1-30'
      })

    assert_instance_of Invoice, invoice
    assert_equal '13579', invoice.id
    assert_equal '23456', invoice.customer_id
    assert_equal '65432', invoice.merchant_id
    assert_equal 'shipped', invoice.status
    assert_equal '2017-1-31', invoice.created_at
    assert_equal '2017-1-30', invoice.updated_at
  end

end
