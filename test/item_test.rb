require_relative 'test_helper'
require_relative '../lib/item_repository'

class ItemTest < Minitest::Test

  def setup
    @ir = ItemRepository.new("./data/items_fixtures.csv")
    @item = @ir.all[0]
  end

  def test_it_returns_id
    assert_equal 263395237, @item.id
  end

  def test_it_returns_name
    assert_equal "510+ RealPush Icon Set", @item.name
  end

  def test_it_returns_description
    assert_equal "this is the description", @item.description
  end

  def test_it_returns_price
    assert_instance_of BigDecimal, @item.unit_price
    assert_equal 12.0, @item.unit_price
  end

  def test_it_returns_merchant_id
    assert_equal 12334141, @item.merchant_id
  end

  def test_has_created_time
    assert_instance_of Time, @item.created_at
  end

  def test_has_updated_time
   assert_instance_of Time, @item.updated_at    
  end

  def test_it_returns_price_in_dollars
    assert_instance_of Float, @item.unit_price_to_dollars 
    assert_equal 12.0, @item.unit_price_to_dollars
  end

end