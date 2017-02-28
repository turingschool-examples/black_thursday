require_relative 'test_helper'
require_relative '../lib/invoice_item'

class InvoiceItemTest < Minitest::Test

  def setup
    @ir = InvoiceItemRepository.new("parent")
    @ir.from_csv("./data/invoice_items_fixture.csv")
    @inv_item = @ir.all[0] 
  end

  def test_it_exists
    assert_instance_of InvoiceItem, @inv_item
  end

  def test_it_returns_id
    assert_equal 1, @inv_item.id
  end

  def test_it_returns_item_id
    assert_equal 263519844, @inv_item.item_id
  end

  def test_it_returns_invoice_id
    assert_equal 1, @inv_item.invoice_id
  end

  def test_it_returns_quantity
    assert_equal 5, @inv_item.quantity
  end

  def test_it_returns_price
    assert_instance_of BigDecimal, @inv_item.unit_price
    assert_equal 136.35, @inv_item.unit_price
  end

  def test_has_created_time
    assert_instance_of Time, @inv_item.created_at
  end

  def test_has_updated_time
   assert_instance_of Time, @inv_item.updated_at    
  end
end
