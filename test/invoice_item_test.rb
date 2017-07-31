require 'simplecov'
require 'minitest/autorun'
require 'minitest/pride'
require 'bigdecimal'
require './lib/invoice_item'

class InvoiceItemTest < Minitest::Test

  def setup
    @invoice_item = InvoiceItem.new({
                                    :id => 6,
                                    :item_id => 7,
                                    :invoice_id => 8,
                                    :quantity => 1,
                                    :unit_price => BigDecimal.new(10.99, 4),
                                    :created_at => "2012-03-27 14:54:09 UTC",
                                    :updated_at => "2012-03-27 14:54:09 UTC"}, "InvoiceItemRepository")
  end

  def test_it_exist
    assert_instance_of InvoiceItem, @invoice_item
    assert_equal 6, @invoice_item.id
    assert_equal 7, @invoice_item.item_id
    assert_equal 8, @invoice_item.invoice_id
    assert_equal 1, @invoice_item.quantity
    assert_instance_of BigDecimal, @invoice_item.unit_price
    assert_instance_of Time, @invoice_item.created_at
    assert_instance_of Time, @invoice_item.updated_at
  end

end
