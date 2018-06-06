require_relative 'test_helper'
require './lib/sales_engine'
require './lib/invoice_item'

class InvoiceItemTest < Minitest::Test
  def setup
    @ii = InvoiceItem.new({
          :id => 6,
          :item_id => 7,
          :invoice_id => 8,
          :quantity => 1,
          :unit_price => BigDecimal.new(1099, 4),
          :created_at  => '2016-01-11 09:34:06 UTC',
          :updated_at  => '2007-06-04 21:35:10 UTC'
        })
  end

  def test_it_exists
    assert_instance_of InvoiceItem, @ii
  end

  def test_it_has_attributes
    assert_equal 6, @ii.id
    assert_equal 7, @ii.item_id
    assert_equal 8, @ii.invoice_id
    assert_equal 1, @ii.quantity
    assert_instance_of BigDecimal, @ii.unit_price
  end

  def test_time_attributes
    assert_instance_of Time, @ii.created_at
    assert_equal 2016, @ii.created_at.year

    assert_instance_of Time, @ii.updated_at
    assert_equal 04, @ii.updated_at.day
  end

  def test_unit_price_to_dollars
    assert_equal 10.99, @ii.unit_price_to_dollars
  end
end
