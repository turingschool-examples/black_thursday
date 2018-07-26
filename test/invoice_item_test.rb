require_relative 'test_helper'
require_relative '../lib/invoice_item'

class InvoiceItemTest < Minitest::Test

  def setup
    @invoice_item = InvoiceItem.new({
                :id => 6,
                :item_id => 7,
                :invoice_id => 8,
                :quantity => 1,
                :unit_price => BigDecimal.new(10.99, 4),
                :created_at => Time.now,
                :updated_at => Time.now
              })
  end

  def test_it_exists
    assert_instance_of InvoiceItem, @invoice_item
  end

  def test_it_has_id
    assert_equal 6, @invoice_item.id
  end

  def test_it_has_item_id
    assert_equal 7, @invoice_item.item_id
  end

  def test_it_has_invoice_id
    assert_equal 8, @invoice_item.invoice_id
  end

  def test_it_has_quantity
    assert_equal 1, @invoice_item.quantity
  end

  def test_it_has_unit_price
    assert_equal 10.99, @invoice_item.unit_price
    assert_instance_of BigDecimal, @invoice_item.unit_price
  end

  def test_it_has_created_at_and_updated_at_time
    assert_instance_of Time, @invoice_item.created_at
    assert_instance_of Time, @invoice_item.updated_at
  end

  def test_it_has_unit_price_to_dollars
    assert_equal 10.99, @invoice_item.unit_price_to_dollars
    assert_instance_of Float, @invoice_item.unit_price_to_dollars
  end
end
