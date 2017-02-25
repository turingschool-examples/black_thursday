require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/invoice'

class InvoiceTest < Minitest::Test
  attr_reader :i
  def setup
    @i = Invoice.new({
      :id          => 6,
      :customer_id => 7,
      :merchant_id => 8,
      :status      => "pending",
      :created_at  => Time.now,
      :updated_at  => Time.now,
    })

  end

  def test_it_gets_items_csv
    result = {
      :id          => 6,
      :customer_id => 7,
      :merchant_id => 8,
      :status      => "pending",
      :created_at  => Time.now,
      :updated_at  => Time.now,
    }
    assert_equal result.inspect, i.invoice_hash.inspect
  end

  def test_it_gets_the_id
    assert_equal 6, i.id
  end

  def test_it_gets_the_customer_id
    assert_equal 7, i.customer_id
  end

  def test_it_gets_the_merchant_id
    assert_equal 8, i.merchant_id
  end

  def test_it_gets_the_status
    assert_equal 'pending', i.status
  end

  def test_it_was_created_at
    assert_equal Time.now.inspect, i.created_at.inspect
  end

  def test_it_was_updated_at
    assert_equal Time.now.inspect, i.updated_at.inspect
  end
end
