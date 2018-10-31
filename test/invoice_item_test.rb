require './test/test_helper'
require './lib/invoice_item'
require 'bigdecimal'

class InvoiceItemTest < Minitest::Test
  def setup
    @now = Time.now
    @invoice_item = InvoiceItem.new({
      :id => 6,
      :item_id => 7,
      :invoice_id => 8,
      :quantity => 1,
      :unit_price => BigDecimal.new(10.99, 4),
      :created_at => @now,
      :updated_at => @now
    })
  end

  def test_it_exists
    assert_instance_of InvoiceItem, @invoice_item
  end

  def test_it_has_an_id
    assert_equal 6, @invoice_item.id
  end

  def test_it_has_an_item_id
    assert_equal 7, @invoice_item.item_id
  end

  def test_it_has_an_invoice_id
    assert_equal 8, @invoice_item.invoice_id
  end

  def test_it_has_a_quantity
    assert_equal 1, @invoice_item.quantity
  end

  def test_it_has_a_unit_price
    assert_equal BigDecimal.new(10.99, 4), @invoice_item.unit_price
  end

  def test_it_has_a_created_at_time
    assert_equal @now, @invoice_item.created_at
  end

  def test_it_has_an_updated_at_time
    assert_equal @now, @invoice_item.updated_at
  end

  def test_it_returns_unit_price_as_float
    assert_equal 10.99, @invoice_item.unit_price_to_dollars
  end
end
