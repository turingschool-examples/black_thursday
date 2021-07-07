require_relative 'test_helper'
require_relative '../lib/invoice_item'
require_relative '../lib/sales_engine'

# This is the invoice item test class.
class InvoiceItemTest < Minitest::Test
  def setup
    @data = {
      id: 1,
      item_id: 26_351_984,
      invoice_id: 1,
      quantity: 5,
      unit_price: 34_873,
      created_at: '2009-02-07',
      updated_at: '2014-03-15'
    }
    @invoice_item = InvoiceItem.new(@data, 'InvoiceItemRepository pointer')
  end

  def test_it_exists
    assert_instance_of InvoiceItem, @invoice_item
  end

  def test_attributes_set_correctly_part_1
    assert_equal 'InvoiceItemRepository pointer', @invoice_item.parent
    assert_equal 1, @invoice_item.id
    assert_equal 26_351_984, @invoice_item.item_id
    assert_equal 1, @invoice_item.invoice_id
  end

  def test_attributes_set_correctly_part_2
    assert_equal 5, @invoice_item.quantity
    assert_equal 348.73, @invoice_item.unit_price
    assert_equal Time.new(2009, 0o2, 0o7), @invoice_item.created_at
    assert_equal Time.new(2014, 0o3, 15), @invoice_item.updated_at
  end

  def test_unit_price_to_dollars
    assert_equal 348.73, @invoice_item.unit_price_to_dollars
  end
end
