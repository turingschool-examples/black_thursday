require_relative 'test_helper'
require './lib/invoice'
require 'pry'

class InvoiceTest < Minitest::Test
  def setup
    @i = Invoice.new({
      :id          => 6,
      :customer_id => 7,
      :merchant_id => 8,
      :status      => "pending",
      :created_at  => "2009-02-07",
      :updated_at  => "2014-03-15",
      })
  end

  def test_it_exist
    assert_instance_of Invoice, @i
  end

  def test_it_returns_a_id
    assert_equal 6, @i.id
  end

  def test_it_returns_customer_id
    assert_equal 7, @i.customer_id
  end

  def test_it_returns_merchant_id
    assert_equal 8, @i.merchant_id
  end

  def test_it_returns_status
    assert_equal :pending, @i.status
  end

  def test_it_returns_a_time_instance_for_date_created
    assert_instance_of Time, @i.created_at
  end

  def test_it_returns_a_time_instance_for_date_updated
    assert_instance_of Time, @i.updated_at
  end
end
