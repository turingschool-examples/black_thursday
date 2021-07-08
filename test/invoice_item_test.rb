require_relative 'test_helper'
require_relative '../lib/invoice_item'

class InvoiceItemTest < MiniTest::Test

  attr_reader   :ii

  def setup
    @ii = InvoiceItem.new({
      :id => 6,
      :item_id => 7,
      :invoice_id => 8,
      :quantity => 1,
      :unit_price => 2196,
      :created_at => "2012-03-27 14:54:09 UTC",
      :updated_at => "2012-03-27 14:54:09 UTC"
    })
  end

  def test_it_exists
    assert_instance_of InvoiceItem, ii
  end

  def test_invoice_item_has_attributes
    assert_equal 6, ii.id
    assert_equal 7, ii.item_id
    assert_equal 8, ii.invoice_id
    assert_equal 1, ii.quantity
    assert_equal 21.96, ii.unit_price
    assert_equal "2012-03-27 14:54:09 UTC", ii.created_at.to_s
    assert_equal "2012-03-27 14:54:09 UTC", ii.updated_at.to_s
  end

  def test_invoice_item_gets_unit_price_to_dollars
    assert_equal 21.96, ii.unit_price_to_dollars
  end

end
