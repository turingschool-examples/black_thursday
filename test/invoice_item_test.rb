require_relative 'test_helper'
require './lib/invoice_item'
require 'bigdecimal'

class InvoiceItemTest < Minitest::Test

  def setup
    @ii = InvoiceItem.new({id: 6,
                           item_id: 7,
                           invoice_id: 8,
                           quantity: 1,
                           unit_price: 13635,
                           created_at: "2012-03-27 14:54:09 UTC",
                           updated_at: "2012-03-27 14:54:09 UTC"
                           })
  end

  def test_instance_of_invoice_item_class
    assert_instance_of InvoiceItem, @ii
  end

  def test_invoice_item_has_an_id
    assert_equal 6, @ii.id
  end

  def test_invoice_item_has_an_item_id
    assert_equal 7, @ii.item_id
  end

  def test_invoice_item_has_an_invoice_id
    assert_equal 8, @ii.invoice_id
  end

  def test_invoice_item_has_a_quantity
    assert_equal 1, @ii.quantity
  end

  def test_unit_price_returns_unit_price
    expected = BigDecimal.new(13635.to_i/100.0,6)
    assert_equal expected, @ii.unit_price
  end

  def test_instance_of_the_created_time
    assert_instance_of Time, @ii.created_at
  end

  def test_instance_of_the_updated_time
    assert_instance_of Time, @ii.updated_at
  end

  def test_conversion_of_unit_price_to_dollars
    assert_equal 136.35, @ii.unit_price_to_dollars
  end

  def test_invoice_item_has_parent_defaulted_to_nil
    assert_nil @ii.parent
  end
end
