require_relative '../test/test_helper'
require_relative '../lib/invoice'

class InvoiceTest < Minitest::Test

  def test_it_exits
    invoice = Invoice.new({
        :id          => 6,
        :customer_id => 7,
        :merchant_id => 8,
        :status      => 'pending',
        :created_at  => Time.now,
        :updated_at  => Time.now,
      })

    assert_instance_of Invoice, invoice
  end

  def test_it_has_attributes
    invoice = Invoice.new({
        :id          => 6,
        :customer_id => 7,
        :merchant_id => 8,
        :status      => 'pending',
        :created_at  => Time.now,
        :updated_at  => Time.now,
      })
    assert_equal 6, invoice.id
    assert_equal 7, invoice.customer_id
    assert_equal 8, invoice.merchant_id
    assert_equal 'pending', invoice.status
    assert_instance_of Time, invoice.created_at
    assert_instance_of Time, invoice.updated_at
  end
end
