require './test/test_helper'
require './lib/invoice_items'

class InvoiceItemsTest < Minitest::Test
  def setup
    @ii = InvoiceItems.new({
  :id => 6,
  :item_id => 7,
  :invoice_id => 8,
  :quantity => 1,
  :unit_price => BigDecimal.new(10.99, 4),
  :created_at => Time.now,
  :updated_at => Time.now
  })
  end

  def test_it_exists
    assert_instance_of InvoiceItems, @ii
  end

  def test_it_can_access_data_from_outside
    assert_equal 6, @ii.id
    assert_equal 7, @ii.item_id
    assert_equal 8, @ii.invoice_id
    assert_equal 1, @ii.quantity
    assert_equal BigDecimal.new(10.99, 4), @ii.unit_price
    assert_instance_of Time, @ii.created_at
    assert_instance_of Time, @ii.updated_at
  end
end
