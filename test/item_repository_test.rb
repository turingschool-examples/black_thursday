require './test/test_helper'
require './lib/item_repository'
require './lib/item'

class ItemRepositoryTest < Minitest::Test
  def setup
    @item_1 = Item.new({
          :id          => 1,
          :name        => "Pencil",
          :description => "You can use it to write things",
          :unit_price  => BigDecimal.new(10.99,4),
          :created_at  => "2016-01-11 12:29:33 UTC",
          :updated_at  => "1993-08-29 22:53:20 UTC",
          :merchant_id => 2
        })
    @item_2 = Item.new({
          :id          => 2,
          :name        => "Marker",
          :description => "You can use it to mark things",
          :unit_price  => BigDecimal.new(12.50,4),
          :created_at  => "2016-01-11 12:02:55 UTC",
          :updated_at  => "1973-05-29 23:44:48 UTC",
          :merchant_id => 3
        })
    @ir = ItemRepository.new
    @ir.add_item(@item_1)
    @ir.add_item(@item_2)
  end

  def test_it_exists
    ir = ItemRepository.new
    assert_instance_of ItemRepository, ir
  end

  def test_it_can_add_items_to_repository
    expected = [@item_1, @item_2]
    assert_equal expected, @ir.all
  end

end
