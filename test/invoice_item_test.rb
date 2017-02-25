require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/invoice_item'

class InvoiceItemTest < Minitest::Test
  attr_reader :ii

  def setup
    @ii = InvoiceItem.new({
    :id => 6,
    :item_id => 7,
    :invoice_id => 8,
    :quantity => 1,
    :unit_price => 1099,
    :created_at => Time.now,
    :updated_at => Time.now
  })
  end

  def test_it_gets_the_id
    assert_equal 6, ii.id
  end

  def test_it_gets_the_item_id
    assert_equal 7, ii.item_id
  end

  def test_it_gets_the_invoice_id
    assert_equal 8, ii.invoice_id
  end

  def test_it_gets_the_quantity
    assert_equal 1, ii.quantity
  end

  def test_it_gets_the_unit_price
    assert_equal BigDecimal.new(1099), ii.unit_price
  end

  def test_it_gets_created_at
    assert_equal Time.now.inspect, ii.created_at.inspect
  end

  def test_it_gets_updated_at
    assert_equal Time.now.inspect, ii.updated_at.inspect
  end

  def test_it_converts_unit_price_to_dollars
    assert_equal 10.99, ii.unit_price_to_dollars
  end
end
