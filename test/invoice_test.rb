require './test/test_helper'
require './lib/invoice'
# require './lib/invoice_repository'

class InvoiceTest < Minitest::Test
  attr_reader :invoice
  def setup
    @invoice = Invoice.new({
  :id          => 6,
  :customer_id => 7,
  :merchant_id => 8,
  :status      => "pending",
  :created_at  => Time.parse("2016-11-01 11:38:28 -0600"),
  :updated_at  => Time.parse("2016-11-01 11:38:28 -0600")}, self)

  end

  def test_it_exists
    assert_instance_of Invoice, invoice
  end

  def test_it_has_attributes
    expected = Time.parse('2016-11-01 11:38:28 -0600')

    assert_equal 6, invoice.id
    assert_equal 7, invoice.customer_id
    assert_equal 8, invoice.merchant_id
    assert_equal 'pending', invoice.status
    assert_equal expected, invoice.created_at
    assert_instance_of Time, invoice.created_at
  end
end
