require_relative 'test_helper'
require './lib/invoice'
require 'bigdecimal'

class InvoiceTest < Minitest::Test
  def setup
    @now = Time.now
    @invoice = Invoice.new({
      :id          => 6,
      :customer_id => 7,
      :merchant_id => 8,
      :status      => "pending",
      :created_at  => @now,
      :updated_at  => @now,
    })
  end

  def test_it_exists
    assert_instance_of Invoice, @invoice
  end

  def test_it_has_an_id
    assert_equal 6, @invoice.id
  end

  def test_it_has_a_customer_id
    assert_equal 7, @invoice.customer_id
  end

  def test_it_has_a_merchant_id
    assert_equal 8, @invoice.merchant_id
  end

  def test_it_has_a_status
    assert_equal "pending", @invoice.status
  end

  def test_it_has_a_created_at_time
    assert_equal @now, @invoice.created_at
  end

  def test_it_has_an_updated_at_time
    assert_equal @now, @invoice.updated_at
  end
end
