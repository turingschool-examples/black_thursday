require_relative 'test_helper'
require 'bigdecimal'
require './lib/item'
require './lib/sales_engine'

class MockItemRepo
end

class ItemTest < Minitest::Test
  ITEM_DATA = {
    :id          => "263538760",
    :name        => "Pencil",
    :description => "You can use it to write things",
    :merchant_id => "12334185",
    :unit_price  => "1200",
    :created_at  => "2016-01-11 09:34:06 UTC",
    :updated_at  => "2007-06-04 21:35:10 UTC"
    }

  def test_it_exists
    item_repo = MockItemRepo.new
    item = Item.new(ITEM_DATA, item_repo)

    assert_instance_of Item, item
  end

  def test_it_has_attributes
    item_repo = MockItemRepo.new
    item = Item.new(ITEM_DATA, item_repo)

    assert_equal 263538760, item.id
    assert_equal "Pencil", item.name
    assert_equal "You can use it to write things", item.description
    assert_instance_of BigDecimal, item.unit_price
    assert_equal 12334185, item.merchant_id
    assert_instance_of Time, item.created_at
    assert_instance_of Time, item.updated_at
    assert_equal item_repo, item.parent
  end

  def test_returns_price_as_float
    @se = SalesEngine.new({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      })
    item = @se.items.find_by_id(263397059)
    assert_equal 130.0, item.unit_price_to_dollars
    assert_equal Float, item.unit_price_to_dollars.class
  end

  def test_update_name_description_time
    item_repo = MockItemRepo.new
    item = Item.new(ITEM_DATA, item_repo)

    item.update_name('bottle')
    assert_equal 'bottle', item.name

    item.update_description('its a bottle')
    assert_equal 'its a bottle', item.description

    time = Time.now.utc
    item.new_update_time(time)
    assert_equal time, item.updated_at
  end
end
