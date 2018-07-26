require './test/test_helper'
require './lib/invoice_item'
require 'bigdecimal'

class InvoiceItemTest < Minitest::Test

  def setup
    @invoice_item = InvoiceItem.new({
      :id         => 6,
      :item_id    => 7,
      :invoice_id => 8,
      :quantity   => 1,
      :unit_price => BigDecimal.new(5.99, 3),
      :created_at => Time.now,
      :updated_at => Time.now
    })

  end

  def test_it_exists
    assert_instance_of InvoiceItem, @invoice_item
  end

  def test_it_has_attributes
    assert_equal 6, @invoice_item.id
    assert_equal 7, @invoice_item.item_id
    assert_equal 8, @invoice_item.invoice_id
    assert_equal 1, @invoice_item.quantity
    assert_equal BigDecimal(5.99, 3), @invoice_item.unit_price
  end

end
