require 'minitest/autorun'
require 'minitest/pride'
require './lib/invoice_item'

class InvoiceItemTest < Minitest::Test

  def setup
    @now
    @ii = InvoiceItem.new({
      :id => "6",
      :item_id => "7",
      :invoice_id => "8",
      :quantity => "1",
      :unit_price => "1099",
      :created_at => @now.to_s,
      :updated_at => @now.to_s
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
    assert_equal BigDecimal.new(10.99, 4), @ii.unit_price
    assert_equal @now, @ii.created_at
    assert_equal @now, @ii.updated_at
  end


end
