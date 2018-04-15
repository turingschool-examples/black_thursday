require_relative 'test_helper'
require './lib/invoice_item'

class InvoiceItemTest < Minitest::Test
  def test_exists
    ii = InvoiceItem.new({:id => 1,
                          :item_id => 2,
                          :invoice_id => 4,
                          :quantity => 5,
                          :unit_price => 13635,
                          :created_at => Time.now.to_s,
                          :updated_at => Time.now.to_s
                          }, nil)
    assert_instance_of InvoiceItem, ii
  end

  def test_it_can_have_attributes
    ii = InvoiceItem.new({:id => 1,
                          :item_id => 2,
                          :invoice_id => 4,
                          :quantity => 5,
                          :unit_price => 13635,
                          :created_at => Time.now.to_s,
                          :updated_at => Time.now.to_s
                          }, nil)
    assert_equal 1, ii.id
    assert_equal 2, ii.item_id
    assert_equal 4, ii.invoice_id
    assert_equal 5, ii.quantity
    # assert_equal 13.64, ii.unit_price
    # assert_equal Time.now.to_s, ii.created_at
    # assert_equal Time.now.to_s, ii.updated_at

  end
end
