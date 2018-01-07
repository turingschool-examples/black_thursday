require './test/test_helper'
require './lib/invoice_item'

class InvoiceItemTest < Minitest::Test
  def setup
    @invoice_items = InvoiceItem.new({
      :id => 6,
      :item_id => 7,
      :invoice_id => 8,
      :quantity => 1,
      :unit_price => BigDecimal.new(1099),
      :created_at => "2012-03-27 14:54:44 UTC",
      :updated_at => "2012-03-27 14:54:44 UTC"
    })
  end

  def test_it_returns_id
    assert_equal 6, @invoice_items.id
  end

  def test_it_returns_item_id
    assert_equal 7, @invoice_items.item_id
  end

  def test_it_returns_invoice_id
    assert_equal 8, @invoice_items.invoice_id
  end

  def test_it_returns_quantity
    assert_equal 1, @invoice_items.quantity
  end

  def test_it_returns_unit_price
    assert_instance_of BigDecimal, @invoice_items.unit_price
    assert_equal 0.1099e2, @invoice_items.unit_price
  end

  def test_it_returns_created_at
    assert_instance_of Time, @invoice_items.created_at
    assert_equal "2012-03-27 14:54:44 UTC", @invoice_items.created_at.to_s
  end

  def test_it_returns_updated_at
    assert_instance_of Time, @invoice_items.updated_at
    assert_equal "2012-03-27 14:54:44 UTC", @invoice_items.updated_at.to_s
  end

  def test_it_returns_unit_price_to_dollars
    assert_equal 10.99, @invoice_items.unit_price_to_dollars
  end
end
