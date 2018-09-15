require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require 'minitest/pride'
require './lib/invoice_item'

class InvoiceItemTest < Minitest::Test

  def test_it_exits
    ii = InvoiceItem.new({
    :id => 6,
    :item_id => 7,
    :invoice_id => 8,
    :quantity => 1,
    :unit_price => BigDecimal.new(10.99, 4),
    :created_at => Time.now,
    :updated_at => Time.now
    })

    assert_instance_of InvoiceItem, ii
  end

  def test_it_has_attributes
    ii = InvoiceItem.new({
    :id => 6,
    :item_id => 7,
    :invoice_id => 8,
    :quantity => 1,
    :unit_price => BigDecimal.new(10.99, 4),
    :created_at => Time.now,
    :updated_at => Time.now
    })

    assert_equal 6, ii.id
    assert_equal 7, ii.item_id
    assert_equal 8, ii.invoice_id
    assert_equal 1, ii.quantity
    assert_instance_of BigDecimal, ii.unit_price
  end

  def test_unit_price_to_dollars_returns_a_float
    ii = InvoiceItem.new({
    :id => 6,
    :item_id => 7,
    :invoice_id => 8,
    :quantity => 1,
    :unit_price => BigDecimal.new(10.99, 4),
    :created_at => Time.now,
    :updated_at => Time.now
    })

    assert_equal 10.99, ii.unit_price_to_dollars
  end


end
