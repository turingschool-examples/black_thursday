# frozen_string_literal: true

require './test/test_helper'
require './lib/invoice'
require './lib/sales_engine'

# invoice test
class InvoiceTest < Minitest::Test
  def setup
    @i = Invoice.new({
      :id          => 6,
      :customer_id => 7,
      :merchant_id => 8,
      :status      => "pending",
      :created_at  => Time.now.to_s,
      :updated_at  => Time.now.to_s,
    }, 'parent')
  end

  def test_it_exists
    assert_instance_of Invoice, @i
  end

  def test_attributes
    assert_equal 6, @i.id
    assert_equal 7, @i.customer_id
    assert_equal 8, @i.merchant_id
    assert_equal :pending, @i.status
  end
end
