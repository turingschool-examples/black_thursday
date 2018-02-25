require_relative 'test_helper'
require_relative '../lib/invoice_item_repository'
require_relative '../lib/invoice_item'
require_relative '../lib/sales_engine'
require 'bigdecimal'
require 'pry'

# tests for invoice item class
class InvoiceItemTest < Minitest::Test
  def setup
    @invoice_item = InvoiceItem.new({ id: 6,
                                      item_id: 7,
                                      invoice_id: 8,
                                      quantity: 1,
                                      unit_price: BigDecimal.new(1099, 4),
                                      created_at: '2012-03-27 14:54:09 UTC',
                                      updated_at: ';2012-03-27 14:54:09 UTC' },
                                    'parent')
  end

  def test_it_exists
    assert_instance_of InvoiceItem, @invoice_item
  end

  def test_it_has_attributes
    assert_equal 6, @invoice_item.id
    assert_equal 7, @invoice_item.item_id
    assert_equal 8, @invoice_item.invoice_id
  end

  def test_it_has_more_attributes
    assert_equal Time.parse('2012-03-27 14:54:09 UTC'), @invoice_item.created_at
    assert_equal Time.parse('2012-03-27 14:54:09 UTC'), @invoice_item.updated_at
    assert_equal 'parent',                              @invoice_item.parent
  end

  def test_unit_price_to_dollars
    assert_instance_of Float, @invoice_item.unit_price_to_dollars
    assert_equal 10.99,       @invoice_item.unit_price_to_dollars
  end
end
