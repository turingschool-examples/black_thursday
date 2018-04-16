require 'bigdecimal'
require 'time'
require_relative 'test_helper'
require_relative '../lib/elementals/invoice_item'

# invoice_item minitest
class InvoiceItemTest < Minitest::Test
  def setup
    @time = Time.now
    @invoice_item = InvoiceItem.new(
      id:           '2',
      item_id:      '263454779',
      invoice_id:   '1',
      quantity:     '9',
      unit_price:   '23324',
      created_at:   '2012-03-27 14:54:09 UTC',
      updated_at:   @time
    )
  end

  def test_it_exists
    assert_instance_of InvoiceItem, @invoice_item
  end

  def test_it_has_an_id
    assert_equal 2, @invoice_item.id
  end

  def test_it_has_an_item_id
    assert_equal 263454779, @invoice_item.item_id
  end

  def test_it_has_an_invoice_id
    assert_equal 1, @invoice_item.invoice_id
  end

  def test_it_has_quantity
    assert_equal 9, @invoice_item.quantity
  end

  def test_it_has_unit_price
    assert_equal 233.24, @invoice_item.unit_price
  end

  def test_it_has_created_at
    assert_equal Time.parse('2012-03-27 14:54:09 UTC'), @invoice_item.created_at
  end

  def test_it_has_updated_at
    assert_equal @time, @invoice_item.updated_at
  end

  def test_it_can_set_unit_price_to_dollars
    assert_instance_of BigDecimal, @invoice_item.unit_price
    assert_equal 233.24, @invoice_item.unit_price
    assert_instance_of Float, @invoice_item.unit_price_to_dollars
  end
end
