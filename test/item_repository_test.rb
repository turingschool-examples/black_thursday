require './test/test_helper'

class ItemRepositoryTest < Minitest::Test

  def setup
    @item_1 = Item.new({
              :id          => 1,
              :name        => "Pencil",
              :description => "You can use it to write things",
              :unit_price  => BigDecimal.new(10.99,4),
              :created_at  => @time,
              :updated_at  => @time,
              :merchant_id => 2
            })

    @item_2 = Item.new({
              :id          => 2,
              :name        => "Pen",
              :description => "You can use it to write things in ink!",
              :unit_price  => BigDecimal.new(32.99,4),
              :created_at  => Time.now,
              :updated_at  => Time.now,
              :merchant_id => 3
            })
    @items = [@item_1, @item_2]
    @ir = ItemRepository.new(@items)
  end

  def test_it_exists
    assert_instance_of ItemRepository, @ir
  end

end
