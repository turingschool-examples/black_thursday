require './test/test_helper'
require './lib/item_repository'
require './lib/item'

class ItemRepositoryTest < Minitest::Test
  def test_it_exists
    ir = ItemRepository.new
    assert_instance_of ItemRepository, ir
  end

  def test_it_can_store_items
    item_1 = Item.new({
          :id          => 1,
          :name        => "Pencil",
          :description => "You can use it to write things",
          :unit_price  => BigDecimal.new(10.99,4),
          :created_at  => Time.new(2015),
          :updated_at  => Time.new(2016),
          :merchant_id => 2
        })
    item_2 = Item.new({
          :id          => 2,
          :name        => "Marker",
          :description => "You can use it to mark things",
          :unit_price  => BigDecimal.new(12.50,4),
          :created_at  => Time.new(2017),
          :updated_at  => Time.new(2018),
          :merchant_id => 2
        })
    ir = ItemRepository.new
    expected = [item_1, item_2]
    assert_equal expected, ir.all
  end
end
