require_relative 'test_helper'
require './lib/invoice'

class TestInvoice < Minitest::Test
  DATA = {
    :id          => "1",
    :customer_id => "1",
    :merchant_id => "12335938",
    :status  => "pending",
    :created_at  => "2009-02-07",
    :updated_at  => "2014-03-15"
    }
  def test_it_exists
    i = Invoice.new(DATA)

    assert_instance_of Invoice, i
  end

  def test_it_has_attributes
    i = Invoice.new(DATA)

    assert_equal 1, i.id
    assert_equal 1, i.customer_id
    assert_equal 12335938, i.merchant_id
    assert_equal :pending, i.status
    assert_instance_of Time, i.created_at
    assert_instance_of Time, i.updated_at
  end
end
