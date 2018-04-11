require_relative 'test_helper'
require_relative '../lib/invoice_item'
require_relative '../lib/sales_engine'

# Test InvoiceItem class
class InvoiceItemTest < Minitest::Test
  def setup
    @time = Time.now
    @inv_it = InvoiceItem.new(
      id:         3,
      item_id:    7,
      invoice_id: 8,
      quantity:   4,
      unit_price: BigDecimal.new(1099),
      created_at: @time,
      updated_at: @time
    )
  end

  def test_it_exists
    assert_instance_of InvoiceItem, @inv_it
  end

  def test_it_has_attributes
    assert_equal 3, @inv_it.id
    assert_equal 7, @inv_it.item_id
    assert_equal 8, @inv_it.invoice_id
    assert_equal 4, @inv_it.quantity
    assert_equal 10.99, @inv_it.unit_price
    assert_equal @time, @inv_it.created_at
    assert_equal @time, @inv_it.updated_at
  end
end
