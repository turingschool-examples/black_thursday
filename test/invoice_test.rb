require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require 'minitest/pride'
require './lib/invoice'

class InvoiceTest < Minitest::Test
  def test_an_invoice_exists
    invoice = Invoice.new({
      id: 1,
      customer_id: 1,
      merchant_id: 12335938,
      status: "pending",
      created_at: "2009-02-07",
      updated_at: "2014-03-15"
    })
    assert_instance_of Invoice, invoice
  end

  def test_an_invoice_has_attributes
    invoice = Invoice.new({
      id: 1,
      customer_id: 1,
      merchant_id: 12335938,
      status: "pending",
      created_at: Time.now.to_s,
      updated_at: Time.now.to_s
    })
    assert_equal 1 , invoice.id
    assert_equal 1 , invoice.customer_id
    assert_equal 12335938 , invoice.merchant_id
    assert_equal :pending , invoice.status
    assert_instance_of Time , invoice.created_at
    assert_instance_of Time , invoice.updated_at
  end
end
