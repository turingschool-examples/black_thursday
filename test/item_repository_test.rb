require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require 'minitest/pride'
require './lib/item'
require './lib/item_repository'
require 'bigdecimal'
require 'time'

class ItemRepositoryTest < Minitest::Test

  def test_it_exists
    ir = ItemRepository.new("./data/items.csv")

    assert_instance_of ItemRepository, ir
  end

  def test_all_returns_array_of_all_items
    ir = ItemRepository.new("./data/items.csv")

    assert_instance_of Item, ir.all[0]
    assert_equal 1367, ir.all.count
  end

  def test_it_can_find_an_item_by_id
    ir = ItemRepository.new("./data/items.csv")

    assert_equal ir.all[2], ir.find_by_id(263395721)
    assert_nil ir.find_by_id(1)
  end

  def test_it_can_find_an_item_by_name
    ir = ItemRepository.new("./data/items.csv")

    assert_equal ir.all[2], ir.find_by_name("Disney scrabble frames")
    assert_nil ir.find_by_name("jsklfdjdk")
  end

  def test_it_can_find_all_items_by_description
    ir = ItemRepository.new("./data/items.csv")
    expected = [ir.all[2],ir.all[709],ir.all[848],ir.all[991]]

    assert_equal expected, ir.find_all_with_description("characters")
    assert_equal [], ir.find_all_with_description("hfdashfa;dshf")
  end

  def test_it_can_find_all_by_price
    ir = ItemRepository.new("./data/items.csv")

    assert_equal [ir.all[2]], ir.find_all_by_price(13.50)
    assert_equal [], ir.find_all_by_price(5555555555555)
  end

  def test_it_can_find_all_by_price_in_range
    ir = ItemRepository.new("./data/items.csv")

    assert_equal 19, ir.find_all_by_price_in_range(1000.00..1500.00).count
    assert_equal [], ir.find_all_by_price_in_range(777777777..777777799999)
  end

  def test_it_can_find_all_by_merchant_id
    ir = ItemRepository.new("./data/items.csv")
    # binding.pry
    assert_equal [ir.all[659],ir.all[658],ir.all[655],ir.all[3],ir.all[2],ir.all[1]].reverse, ir.find_all_by_merchant_id(12334185)
    assert_equal [], ir.find_all_by_merchant_id(9999999999)
  end

  def test_that_it_can_create_an_item
    ir = ItemRepository.new("./data/items.csv")
    data = ({
      :name        => "Pencil",
      :description => "You can use it to write things",
      :unit_price  => BigDecimal.new(10.99,4),
      :created_at  => Time.now,
      :updated_at  => Time.now,
      :merchant_id => 2
    })
    actual = ir.create(data).last
    expected = ir.find_by_id(263567475)
    assert_equal expected, actual
  end

  def test_it_can_update_one_attribute_of_an_existing_item
    ir = ItemRepository.new("./data/items.csv")
    ir.update(263395721, {name: "Shopin2018"})
    updated_item = ir.all[2]
    assert_equal "Shopin2018" , updated_item.name
  end

  def test_it_can_delete_an_item
    mr = ItemRepository.new("./data/items.csv")
    mr.delete(263395721)
    assert_nil mr.find_by_id(263395721)
  end
end
