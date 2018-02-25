require_relative 'test_helper'
require_relative '../lib/invoice_item'
require 'bigdecimal'
require 'time'

class InvoiceItemTest < Minitest::Test

  def setup
    data = {
      id:           6,
      item_id:      7,
      invoice_id:   8,
      quantity:     1,
      unit_price:   BigDecimal.new(10.994, 4),
      created_at:   "2018-02-02 14:37:20 -0700",
      updated_at:   "2018-02-02 14:37:20 -0700"
      }
    @invoice_item = InvoiceItem.new(data)
  end

  def test_if_it_exists
    assert_instance_of InvoiceItem, @invoice_item
  end

  def test_if_it_has_attributes
    assert_equal 6, @invoice_item.id
    assert_equal 7, @invoice_item.item_id
    assert_equal 8, @invoice_item.invoice_id
    assert_equal 1, @invoice_item.quantity
    assert_equal 0.1099e0, @invoice_item.unit_price
    assert @invoice_item.created_at.class == Time
    assert @invoice_item.updated_at.class == Time
  end

  def test_if_it_can_return_unit_price_in_dollars
    assert_equal "$0.1099", @invoice_item.unit_price_to_dollars
  end

end
