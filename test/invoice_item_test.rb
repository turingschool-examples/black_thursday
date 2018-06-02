require_relative 'test_helper'
require 'bigdecimal'
require './lib/invoice_item'

class InvoiceItemTest < Minitest::Test
  DATA = {
    :id          => "1",
    :item_id     => "263519844",
    :invoice_id => "1",
    :quantity => "5",
    :unit_price  => "34873",
    :created_at  => "2016-01-11 09:34:06 UTC",
    :updated_at  => "2007-06-04 21:35:10 UTC"
    }

  def test_it_exists
    i = InvoiceItem.new(DATA)

    assert_instance_of InvoiceItem, i
  end

  def test_it_has_attributes
    i = InvoiceItem.new(DATA)

    assert_equal 1, i.id
    assert_equal 263519844, i.item_id
    assert_equal 1, i.invoice_id
    assert_equal 5, i.quantity
    assert_equal 348.73, i.unit_price
    assert_instance_of Time, i.created_at
    assert_instance_of Time, i.updated_at
  end

  def test_unit_price_changes_to_float
    i = InvoiceItem.new(DATA)

    assert_equal 348.73, i.unit_price_to_dollars
    assert_equal Float, i.unit_price_to_dollars.class
  end

end
