require 'minitest/autorun'
require './lib/sales_engine'
require 'bigdecimal'
require 'bigdecimal/util'
require 'pry'
require 'bigdecimal'
# require 'time'

require 'csv'

class ItemTest < Minitest:: Test
  def test_it_knows_it_came_from
    item_repo = ItemRepository.new("")
    item_repo.create_item(
    "./test/fixtures/items_fixture_5lines.csv",
    )
    item = item_repo.items.first

    assert_equal item_repo, item.repository
  end

  def test_it_can_create_an_item
    i = Item.new({
              :name        => "Pencil",
              :description => "You can use it to write things",
              :unit_price  => BigDecimal.new(10.99,4),
              :created_at  => Time.now,
              :updated_at  => Time.now,
              :merchant_id => 24
      })

      assert_instance_of Item, i
  end

  def test_it_can_convert_unit_price_to_dollars
    i = Item.new({
              :name        => "Pencils",
              :description => "You can use them to write things",
              :unit_price  => BigDecimal.new(10.99,4),
              :created_at  => Time.now,
              :updated_at  => Time.now,
              :merchant_id => 24
      })

      assert_equal 0.1099e0, i.unit_price_to_dollars


  end

end
