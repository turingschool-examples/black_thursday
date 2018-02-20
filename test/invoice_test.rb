require 'test_helper'
require_relative '../lib/invoice'

class InvoiceTest < Minitest::Test
  def test_it_exists
    invoice = Invoice.new({
      id:          6,
      customer_id: 7,
      merchant_id: 8,
      status:      "pending",
      created_at:  Time.now,
      updated_at:  Time.now
      })

    assert_instance_of Invoice, invoice
  end

  def test_invoice_attributes_accessible
    invoice = Invoice.new({
      id:          6,
      customer_id: 7,
      merchant_id: 8,
      status:      "pending",
      created_at:  Time.now,
      updated_at:  Time.now
      })

    assert_equal 6, invoice.id
    assert_equal 7, invoice.customer_id
    assert_equal 8, invoice.merchant_id
    assert_instance_of "pending", invoice.status
    assert_instance_of Time, invoice.created_at
  end

  def test_invoice_can_have_different_attributes
    invoice = Invoice.new({
      id:          66,
      customer_id: 77,
      merchant_id: 88,
      status:      'ready',
      created_at:  Time.at(1_498_280_000),
      updated_at:  Time.at(1_498_280_000)
      })
    created_time = Time.at(1_498_280_000)

    assert_equal 66, invoice.id
    assert_equal 77, invoice.customer_id
    assert_equal 88, invoice.merchant_id
    assert_equal 'ready', invoice.status
    assert_equal created_time, invoice.created_at
  end
end
