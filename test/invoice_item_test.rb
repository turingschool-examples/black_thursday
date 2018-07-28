# frozen_string_literal: true

require 'simplecov'
SimpleCov.start

require 'minitest/autorun'
require 'minitest/emoji'
require 'bigdecimal'

require './lib/invoice_item'

# InvoiceItem test class
class InvoiceItemTest < Minitest::Test
  def setup
    @ii = InvoiceItem.new(
      id:           1000,
      item_id:      100,
      invoice_id:   10,
      quantity:     1,
      unit_price:   '2099',
      created_at:   Time.now,
      updated_at:   Time.now
    )
  end

  def test_it_exists
    assert_instance_of InvoiceItem, @ii
  end

  def test_it_has_attributes
    assert_equal 1000, @ii.id
    assert_equal 100, @ii.item_id
    assert_equal 10, @ii.invoice_id
    assert_equal 1, @ii.quantity
    assert_equal BigDecimal(20.99, 4), @ii.unit_price
    assert_instance_of Time, @ii.created_at
    assert_instance_of Time, @ii.updated_at
  end

  def test_it_gives_unit_price_in_dollars
    assert_equal 20.99, @ii.unit_price_to_dollars
  end
end
