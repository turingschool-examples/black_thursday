require 'minitest/autorun'
require 'bigdecimal'
require 'time'
require 'minitest/pride'
require './lib/invoice_item'

class InvoiceItemTest < Minitest::Test

  def setup
    @time = "2016-01-11 09:34:06 UTC"
    @ii = InvoiceItem.new({
      :id => "6",
      :item_id => "7",
      :invoice_id => "8",
      :quantity => "1",
      :unit_price => "1099",
      :created_at => @time,
      :updated_at => @time
    })
  end

  def test_it_exists
    assert_instance_of InvoiceItem, @ii
  end

  def test_it_has_attributes
    assert_equal 6, @ii.id
    assert_equal 7, @ii.item_id
    assert_equal 8, @ii.invoice_id
    assert_equal 1, @ii.quantity
    assert_instance_of BigDecimal, @ii.unit_price
    assert_instance_of Time, @ii.created_at
    assert_instance_of Time, @ii.updated_at
  end


end
