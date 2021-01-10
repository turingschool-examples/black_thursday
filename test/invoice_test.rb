require 'minitest/autorun'
require 'minitest/pride'
require './lib/invoice'
require 'time'

class InvoiceTest < Minitest::Test
  def test_it_has_attributes
    invoice = Invoice.new({
  :id          => 6,
  :customer_id => 7,
  :merchant_id => 8,
  :status      => "pending",
  :created_at  => Time.now.to_s,
  :updated_at  => Time.now.to_s,
  })

  assert_instance_of Invoice, invoice
  assert_equal 6, invoice.id
  assert_instance_of Time, invoice.created_at
  assert_instance_of Time, invoice.updated_at
  assert_equal 8, invoice.merchant_id
  assert_equal 7, invoice.customer_id
  assert_equal "pending", invoice.status
  end
end
