# frozen_string_literal: true

require 'timecop'
require './test/test_helper'
require './lib/invoice'
require './lib/sales_engine'

# invoice test
class InvoiceTest < Minitest::Test
  def setup
    Timecop.freeze

    @i = Invoice.new({
      id:           6,
      customer_id:  7,
      merchant_id:  8,
      status:       "pending",
      created_at:   Time.now.to_s,
      updated_at:   Time.now.to_s,
    }, 'parent')
  end

  def teardown
    Timecop.return
  end

  def test_it_exists
    assert_instance_of Invoice, @i
  end

  def test_attributes
    assert_equal 6, @i.id
    assert_equal 7, @i.customer_id
    assert_equal 8, @i.merchant_id
    assert_equal :pending, @i.status
    assert_equal Time.now.to_s, @i.created_at.to_s
    assert_equal Time.now.to_s, @i.updated_at.to_s
  end

  def test_change_attributes
    assert_equal :pending, @i.status

    @i.change_shipping_status('shipped')

    assert_equal :shipped, @i.status
  end
end
