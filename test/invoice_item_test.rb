require 'simplecov'
SimpleCov.start
require 'bigdecimal'
require 'time'
require 'minitest/autorun'
require 'minitest/pride'
require 'pry'
require_relative '../lib/invoice_item'

class InvoiceItemTest < Minitest::Test

  def setup
    @ii = InvoiceItem.new({
      :id => 1,
      :item_id => 12,
      :quantity => 150,
      :unit_price => BigDecimal.new(10.99, 4),
      :created_at => Time.now,
      :updated_at => Time.now
      })
  end

  def test_it_exists
    assert_instance_of InvoiceItem, @ii
  end

  def test_it_has_attributes
    assert_equal 1, @ii.id
    assert_equal 12, @ii.item_id
    assert_equal 0.1099, @ii.unit_price
    assert_instance_of Time, @ii.created_at
    assert_instance_of Time, @ii.updated_at
  end

  def test_it_returns_unit_price_in_dollars
    assert_equal 0.1099, @ii.unit_price_to_dollars
  end
end
