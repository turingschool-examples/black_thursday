require_relative '../test/test_helper'
require_relative '../lib/invoice_item'
require 'time'


class InvoiceItemTest < Minitest::Test
  def setup
    args = {
        :id => 6,
        :item_id => 7,
        :invoice_id => 8,
        :quantity => 1,
        :unit_price => BigDecimal.new(10.99, 4),
        :created_at => Time.now,
        :updated_at => Time.now
        }
    @ii = InvoiceItem.new(args)
  end

  def test_it_exists
    assert_instance_of InvoiceItem, @ii
  end

  def test_it_has_attributes
    assert_equal 6, @ii.id
    assert_equal 7, @ii.item_id
    assert_equal 8, @ii.invoice_id
    assert_equal 1, @ii.quantity
    assert_equal 10.99, @ii.unit_price.to_f
    assert_instance_of Time, @ii.created_at
    assert_instance_of Time, @ii.updated_at
  end
end
