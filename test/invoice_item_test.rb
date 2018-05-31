require './test/test_helper'
require './lib/invoice_item'
require 'bigdecimal'

class InvoiceItemTest < Minitest::Test

  def setup
    attributes = {
      :id => '6',
      :item_id => '7',
      :invoice_id => '8',
      :quantity => '1',
      :unit_price => BigDecimal.new(10.99, 4),
      :created_at => Time.now,
      :updated_at => Time.now
    }

    @inv_item = InvoiceItem.new(attributes)
  end

  def test_it_exists
    assert_instance_of InvoiceItem, @inv_item
  end

  def test_it_has_attributes
    assert_equal 6, @inv_item.id
    assert_equal 7, @inv_item.item_id
    assert_equal 8, @inv_item.invoice_id
    assert_equal 1, @inv_item.quantity
    assert_equal 10.99, @inv_item.unit_price
    assert_instance_of Time, @inv_item.created_at
    assert_instance_of Time, @inv_item.updated_at
  end
end
