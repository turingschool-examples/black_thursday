require './test/test_helper'
require './lib/item'

class ItemTest < Minitest::Test
  attr_reader :item, :parent
  def setup
    @parent = Minitest::Mock.new
    @item = Item.new({
                    :id => 263395237, 
                    :name => "510+ RealPush Icon Set", 
                    :description => HTMLEntities.new.decode("You&#39;ve got a total socialmedia iconset! Almost every social icon on the planet earth."), 
                    :unit_price => BigDecimal.new(1200), 
                    :merchant_id => 12334141, 
                    :created_at => Time.utc(2016, 1, 11, 9, 34, 06), 
                    :updated_at => Time.utc(2007, 6, 4, 21, 35, 10)
                    },
                    parent)
  end

  def test_it_stores_item_number
    assert_equal 263395237, item.id
  end

  def test_it_stores_item_name
    assert_equal "510+ RealPush Icon Set", item.name
  end

  def test_it_stores_item_description
    description = "You've got a total socialmedia iconset! Almost every social icon on the planet earth."
    assert_equal description, item.description
  end

  def test_it_stores_unit_price_as_bigdecimal
    assert_equal 1200, item.unit_price.to_i
  end

  def test_it_stores_merchant_id
    assert_equal 12334141, item.merchant_id
  end

  def test_it_stores_time_created_at
      assert_equal 2016, item.created_at.year
  end

  def test_it_stores_time_updated_at
    assert_equal 2007, item.updated_at.year
  end

  def test_it_stores_unit_price_as_dollars
    assert_equal 12.00, item.unit_price_as_dollars
  end

  def test_it_calls_parent_when_looking_for_merchant
    parent.expect(:find_merchant_by_merchant_id, nil, [12334141]) 
    item.merchant
    parent.verify
  end

end