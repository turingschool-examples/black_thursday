# frozen_string_literal: true

require 'timecop'
require './test/test_helper'
require './lib/invoice_item'
require './lib/sales_engine'

# invoice item test
class InvoiceItemTest < Minitest::Test
  def setup
    Timecop.freeze

    @i = InvoiceItem.new({
      id:          6,
      item_id:     7,
      invoice_id:  8,
      quantity:    9,
      unit_price:  123_456,
      created_at:  Time.now.to_s,
      updated_at:  Time.now.to_s,
    }, 'parent')
  end

  def teardown
    Timecop.return
  end

  def test_it_exists
    assert_instance_of InvoiceItem, @i
  end

  def test_attributes
    assert_equal 6, @i.id
    assert_equal 7, @i.item_id
    assert_equal 8, @i.invoice_id
    assert_equal 9, @i.quantity
    assert_equal 1234.56, @i.unit_price
    assert_equal Time.now.to_s, @i.created_at.to_s
    assert_equal Time.now.to_s, @i.updated_at.to_s
  end

  def test_unit_price_to_dollars
    assert_equal 1234.56, @i.unit_price_to_dollars
  end

  def test_change_attributes
    assert_equal 0.123456e4, @i.unit_price
    assert_equal 9, @i.quantity

    @i.change_unit_price(1)
    @i.change_quantity(1)

    assert_equal 1, @i.unit_price
    assert_equal 1, @i.quantity
  end
end
