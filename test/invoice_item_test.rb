# frozen_string_literal: false

require_relative 'test_helper'
require './lib/invoice_item'

class InvoiceItemTest < Minitest::Test
  def setup
    @args = { id: 6,
              item_id: 7,
              invoice_id: 8,
              quantity: 1,
              unit_price: BigDecimal(1099, 4),
              created_at: '2016-01-11 09:34:06 UTC',
              updated_at: '2007-06-04 21:35:10 UTC' }
    @invoice_items = InvoiceItem.new(@args)
  end

  def test_it_exists
    assert_instance_of InvoiceItem, @invoice_items
  end

  def test_it_has_attributes
    assert_equal 6, @invoice_items.id
    assert_equal 7, @invoice_items.item_id
    assert_equal 8, @invoice_items.invoice_id
    assert_equal 1, @invoice_items.quantity
    assert_instance_of BigDecimal, @invoice_items.unit_price
  end

  def test_time_attributes_for_created
    assert_instance_of Time, @invoice_items.created_at
    assert_equal 2_016, @invoice_items.created_at.year
    assert_equal 11, @invoice_items.created_at.day
  end

  def test_time_attributes_for_updated
    assert_instance_of Time, @invoice_items.updated_at
    assert_equal 4, @invoice_items.updated_at.day
    assert_equal 6, @invoice_items.updated_at.month
  end

  def test_unit_price_to_dollars
    assert_instance_of Float, @invoice_items.unit_price_to_dollars
    assert_equal 10.99, @invoice_items.unit_price_to_dollars
  end
end
