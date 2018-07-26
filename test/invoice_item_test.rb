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
end
