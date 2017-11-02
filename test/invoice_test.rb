require_relative './test_helper'
require './lib/invoice'

class InvoiceTest < Minitest::Test
  attr_reader :invoice_1, :invoice_2
  def setup
    parent = mock("parent")
    @invoice_1 = Invoice.new({
      :id => '24680',
      :customer_id => '12345',
      :merchant_id => '54321',
      :status => 'pending',
      :created_at => '2017-10-31',
      :updated_at => '2017-10-30'
      }, parent)
    @invoice_2 = Invoice.new({
      :id => '13579',
      :customer_id => '23456',
      :merchant_id => '65432',
      :status => 'shipped',
      :created_at => '2017-1-31',
      :updated_at => '2017-1-30'
      }, parent)
  end
  def test_invoice_accepts_attributes
    assert_instance_of Invoice, invoice_1
    assert_equal '24680', invoice_1.id
    assert_equal '12345', invoice_1.customer_id
    assert_equal '54321', invoice_1.merchant_id
    assert_equal 'pending', invoice_1.status
    assert_equal '2017-10-31', invoice_1.created_at
    assert_equal '2017-10-30', invoice_1.updated_at
  end

  def test_invoice_accepts_other_attributes
    assert_instance_of Invoice, invoice_2
    assert_equal '13579', invoice_2.id
    assert_equal '23456', invoice_2.customer_id
    assert_equal '65432', invoice_2.merchant_id
    assert_equal 'shipped', invoice_2.status
    assert_equal '2017-1-31', invoice_2.created_at
    assert_equal '2017-1-30', invoice_2.updated_at
  end

  def test_can_use_merchant
    invoice_1.parent.stubs(:find_merchant_by_merchant_id).with("54321").returns(true)
    invoice_2.parent.stubs(:find_merchant_by_merchant_id).with("65432").returns(true)

    assert invoice_1.merchant
    assert invoice_2.merchant
  end
end
