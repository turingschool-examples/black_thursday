require './test/test_helper'
require './lib/invoice'

# Tests the invoice class
class InvoiceTest < Minitest::Test
  def setup
    @invoice = Invoice.new(id: 6,
                           customer_id: 7,
                           merchant_id: 8,
                           status: 'pending',
                           created_at: '1969-07-20 20:17:40 -0600',
                           updated_at:  '1969-07-20 20:17:40 -0600')
  end

  def test_it_exists
    assert_instance_of Invoice, @invoice
  end

  def test_it_returns_integer_id
    assert_instance_of Integer, @invoice.id
    assert_equal 6, @invoice.id
  end

  def test_it_returns_customer_id
    assert_instance_of Integer, @invoice.customer_id
    assert_equal 7, @invoice.customer_id
  end

  def test_it_returns_merchant_id
    assert_instance_of Integer, @invoice.merchant_id
    assert_equal 8, @invoice.merchant_id
  end

  def test_it_returns_status
    assert_instance_of Symbol, @invoice.status
    assert_equal :pending, @invoice.status
  end

  def test_it_returns_a_time_when_created
    assert_instance_of String, @invoice.created_at.to_s
    assert_equal '1969-07-20 20:17:40 -0600', @invoice.created_at.to_s
  end

  def test_it_returns_time_when_updated
    assert_instance_of String, @invoice.updated_at.to_s
    assert_equal '1969-07-20 20:17:40 -0600', @invoice.updated_at.to_s
  end
end
