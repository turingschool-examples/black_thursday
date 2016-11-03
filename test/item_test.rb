require_relative 'test_helper'
require_relative '../lib/item'

class ItemTest < Minitest::Test

  attr_reader :item
  
  def setup
    @item = Item.new({
      :id          => "2345",
      :name        => "Pencil",
      :description => "You can use it to write things",
      :unit_price  => "1099",
      :created_at  => Time.now.to_s,
      :updated_at  => Time.now.to_s,
      :merchant_id => '3333'
    })
  end

  def test_Item_exists
    assert item
  end

  def test_item_knows_name
    assert_equal "Pencil", item.name
  end

  def test_item_knows_description
    assert_equal "You can use it to write things", item.description
  end

  def test_item_knows_unit_price
    assert_equal BigDecimal.new(10.99,4), item.unit_price
  end

  def test_item_knows_time_created_at
    assert_equal Time.now.to_s, item.created_at.to_s
  end

  def test_item_knows_time_updated_at
    assert_equal Time.now.to_s, item.updated_at.to_s
  end

  def test_unit_price_to_dollars_returns_float_of_price
    assert_equal 10.99, item.unit_price_to_dollars
  end

  def test_item_knows_its_id
    assert_equal 2345, item.id
  end

  def test_item_knows_its_merchant_id
    assert_equal 3333, item.merchant_id
  end

  # def test_item_call_sales_engine
  #   sales_engine = Minitest::Mock.new
  #   sales_engine.expect(:find_by_id, nil, [1])
  #   item.merchant
  #   sales_engine.verify
  # end

end