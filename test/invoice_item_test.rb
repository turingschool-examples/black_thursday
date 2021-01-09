require 'minitest/autorun'
require 'minitest/pride'
require './lib/invoice_item'

class InvoiceItemTest < Minitest::Test
  def setup
    @ii = InvoiceItem.new({
      :id => 6,
      :item_id => 7,
      :invoice_id => 8,
      :quantity => 1,
      :unit_price => BigDecimal.new(10.99, 4),
      :created_at => 10,
      :updated_at => 12
    })
  end

  def test_it_exists_with_attributes
    assert_instance_of InvoiceItem, @ii
    assert_equal 6, @ii.id
    assert_equal Fixnum, @ii.id.class
    assert_equal 7, @ii.item_id
    assert_equal Fixnum, @ii.item_id.class
    assert_equal 8, @ii.invoice_id
    assert_equal Fixnum, @ii.invoice_id.class
    assert_equal 0.1099e2, @ii.unit_price
    assert_equal BigDecimal, @ii.unit_price.class
    assert_equal 10, @ii.created_at
    assert_equal 12, @ii.updated_at
  end
end
