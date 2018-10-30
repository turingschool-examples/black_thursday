require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require 'minitest/pride'
require 'bigdecimal'
require './lib/invoice_item'

class InvoiceItemTest < Minitest::Test

  def test_it_exists
  ii = InvoiceItem.new({
  :id => 6,
  :item_id => 7,
  :invoice_id => 8,
  :quantity => 1,
  :unit_price => BigDecimal.new(10.99, 4),
  :created_at => Time.now.to_s,
  :updated_at => Time.now.to_s
})
  assert_instance_of InvoiceItem, ii
  end

  def test_it_has_attirbutes
    ii = InvoiceItem.new({
    :id => 6,
    :item_id => 7,
    :invoice_id => 8,
    :quantity => 1,
    :unit_price => BigDecimal.new(10.99, 4),
    :created_at => Time.now.to_s,
    :updated_at => Time.now.to_s
    })
    assert_equal 6, ii.id
    assert_equal 7, ii.item_id
    assert_equal 8, ii.invoice_id
    assert_equal 1, ii.quantity
    assert_equal BigDecimal.new(10.99, 4), ii.unit_price
    assert_instance_of Time, ii.created_at
    assert_instance_of Time, ii.updated_at
  end

  def test_it_has_attirbutes
    ii = InvoiceItem.new({
    :id => 6,
    :item_id => 7,
    :invoice_id => 8,
    :quantity => 1,
    :unit_price => BigDecimal.new(1099.111,4),
    :created_at => Time.now.to_s,
    :updated_at => Time.now.to_s
    })
    assert_equal 10.99, ii.unit_price_to_dollars
  end

end
