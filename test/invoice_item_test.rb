require_relative './test_helper'
require_relative '../lib/invoice_item'
require_relative '../lib/data_parser'

class InvoiceItemTest < Minitest::Test
  include DataParser
  def test_invoice_item_class_exists
    assert_instance_of InvoiceItem, InvoiceItem.new({
  :id         => 6,
  :item_id    => 7,
  :invoice_id => 8,
  :quantity   => 1,
  :unit_price => BigDecimal.new(10.99, 4),
  :created_at => Time.now,
  :updated_at => Time.now
  })
  end

  def test_invoice_item_can_access_invoice_item_attributes
    ii = InvoiceItem.new({
    :id         => 6,
    :item_id    => 7,
    :invoice_id => 8,
    :quantity   => 1,
    :unit_price => 110000,
    :created_at => Time.now,
    :updated_at => Time.now
    })
    assert_equal 6, ii.id
    assert_equal 7, ii.item_id
    assert_equal 8, ii.invoice_id
    assert_equal 1, ii.quantity
    assert_equal 1100.00, ii.unit_price
    assert_respond_to ii, :created_at
    assert_respond_to ii, :updated_at
  end

end
