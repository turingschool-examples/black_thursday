require 'minitest/autorun'
require 'minitest/pride'
require './lib/item'
require './lib/item_repository'
require './lib/sales_engine'

class ItemRepositoryTest < Minitest::Test

  def test_it_exists_and_has_attributes
    ir = ItemRepository.new("./data/items.csv")
    assert_instance_of ItemRepository, ir
    assert_equal "./data/items.csv", ir.path
  end

  def test_it_read_items
      ir = ItemRepository.new("./data/items.csv")
      assert_equal 1367, ir.items.count
    end

  def test_returns_all
    ir = ItemRepository.new("./data/items.csv")
    assert_equal 1367, ir.all.count
  end

  def test_find_by_id_returns_an_instance_of_item
    ir = ItemRepository.new("./data/items.csv")
    assert_instance_of Item, ir.find_by_id(263399037)
    assert_equal "Green Footed Ceramic Bowl", ir.find_by_id(263399037).name
  end

  def test_find_by_name
    ir = ItemRepository.new("./data/items.csv")

    assert_equal 263553176, ir.find_by_name("Pink Depression Grill Plate Miss America Pattern").id
    assert_nil ir.find_by_name("abc")
  end

  def test_find_all_with_description
    ir = ItemRepository.new("./data/items.csv")

    i = Item.new({
                  :id          => 263550472,
                  :name        => "Pencil",
                  :description => "A large Yeti of sorts, casually devours a cow as the others watch numbly.",
                  :unit_price  => BigDecimal(10.99,4),
                  :created_at  => "#{Time.now}",
                  :updated_at  => "#{Time.now}",
                  :merchant_id => 2
                  })

    assert_equal 1, ir.find_all_by_description("A large Yeti of sorts, casually devours a cow as the others watch numbly.").count
    assert_equal [], ir.find_all_by_description("akjhaskjdh223k1jh2hash")
  end

end
