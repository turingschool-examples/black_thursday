require_relative '../lib/invoice'
require_relative './test_helper'

class InvoiceTest <Minitest::Test
  def test_it_exists
    i = Invoice.new({
    :id          => 6,
    :customer_id => 7,
    :merchant_id => 8,
    :status      => "pending",
    :created_at  => Time.now,
    :updated_at  => Time.now
    })

    assert_instance_of Invoice, i
  end

  def test_it_has_attributes
    i = Invoice.new({
    :id          => 6,
    :customer_id => 7,
    :merchant_id => 8,
    :status      => "pending",
    :created_at  => "2016-01-11 12:29:33 UTC",
    :updated_at  => "2018-01-11 12:29:33 UTC"
    })

    assert_equal 6,i.id
    assert_equal 7,i.customer_id
    assert_equal 8,i.merchant_id
    assert_equal :pending ,i.status
    assert_equal Time.parse("2016-01-11 12:29:33 UTC"),i.created_at
    assert_equal Time.parse("2018-01-11 12:29:33 UTC"),i.updated_at
  end

end
