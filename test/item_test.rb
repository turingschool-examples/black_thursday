require 'minitest/autorun'
require './lib/sales_engine'
require 'pry'
require 'csv'

class ItemTest < Minitest:: Test
  def test_it_knows_it_came_from

    item_repo = ItemRepository.new("")
    item_repo.create_item({
      :items     => "./data/items_fixture_5lines.csv",
      # :merchants => "./data/merchants_5lines.csv",
    })

    item = item_repo.items.first
    # binding.pry
    assert_equal [item_repo], item.repository
  end

  def test_it_can_find_the_associated_merchant
    skip
    se =SalesEngine.new
    se.merchants.create_merchant({:name =>"the merch", :id => 24})
    merchant = se.merchant_repository.merchants.first
    se.items.create_item({:name => "merchthang", :merchant_id => 24})
    item = se.item_repository.items.first

    assert_equal merchant,  item.merchant
  end
  def test_it_can_create_an_item
      i = Item.new({
    :name        => "Pencil",
    :description => "You can use it to write things",
    :unit_price  => BigDecimal.new(10.99,4),
    :created_at  => Time.now,
    :updated_at  => Time.now,
      })

      assert_instance_of Item, i
  end

end
