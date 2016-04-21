require './test/test_helper'

class ItemTest < Minitest::Test

  def test_id
    item = @engine.items.all.first
    assert_equal 263396209, item.id
  end

  def test_name
    item = @engine.items.all.first
    assert_equal 'Vogue Paris Original Givenchy 2307', item.name
  end

  def test_description
    item = @engine.items.all[3]
    assert_equal '8x11 hand painted canvas', item.description
  end

  def test_unit_price_is_Big_Decimal
    item = @engine.items.all.last
    assert_equal BigDecimal, item.unit_price.class
  end

  def test_unit_price_to_dollars
    item = @engine.items.all.last
    assert_equal 14.00, item.unit_price_to_dollars
  end

  def test_created_at
    item = @engine.items.all.last
    assert_equal Time, item.created_at.class
  end

  def test_updated_at
    item = @engine.items.all.last
    assert_equal Time, item.updated_at.class
  end

  def test_merchant_id
    item = @engine.items.all.last
    assert_equal 12334135, item.merchant_id
  end

  def test_item_can_find_its_merchant
    item = @engine.items.all.first
    assert_equal 263396209, item.id
    merchant = item.merchant
    assert_equal 'Shopin1901', merchant.name
  end
end
