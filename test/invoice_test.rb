require './test/test_helper'
require './lib/invoice'
require 'time'

class InvoiceTest < Minitest::Test
  def setup
    invoice = ({
      id: "1",
      customer_id: "1",
      merchant_id: "12335938",
      status: "pending",
      created_at: "2009-02-07",
      updated_at: "2014-03-15"
    })
    @invoice = Invoice.new(invoice)
  end

  def test_invoice_exists
    assert_instance_of Invoice, @invoice
  end

  def test_invoice_has_attributes
    assert_equal 1, @invoice.id
    assert_equal 1, @invoice.customer_id
    assert_equal 12335938, @invoice.merchant_id
    assert_equal :pending, @invoice.status
    assert_equal Time.parse("2009-02-07"), @invoice.created_at
    assert_equal Time.parse("2014-03-15"), @invoice.updated_at
  end
end
