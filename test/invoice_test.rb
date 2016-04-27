require_relative 'test_helper'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/invoice'

class InvoiceTest < Minitest::Test
  attr_reader :i

  def setup
    @i = Invoice.new({
      :id          => "263410303",
      :customer_id => "12233444",
      :merchant_id => "1234566",
      :status      => "pending",
      :created_at  => "2016-04-19 09:04:25 -0600",
      :updated_at  => "2016-04-19 09:04:25 -0600"
    })
  end

  def test_it_returns_its_id_as_an_integer
    assert_equal 263410303, i.id
  end

  def test_it_returns_its_customer_id_as_an_integer
    assert_equal 12233444, i.customer_id
  end

  def test_it_returns_its_merchant_id_as_an_integer
    assert_equal 1234566, i.merchant_id
  end

  def test_it_returns_status_as_a_symbol
    assert_equal :pending, i.status
  end

  def test_it_can_return_the_time_it_was_created
    assert_equal Time.parse("2016-04-19 09:04:25 -0600"), i.created_at
  end

  def test_it_can_return_the_time_it_was_last_updated
    assert_equal Time.parse("2016-04-19 09:04:25 -0600"), i.updated_at
  end

  def test_it_can_be_inspected
    assert_equal "#<Invoice" , i.inspect
  end
end
