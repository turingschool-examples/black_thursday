require_relative 'test_helper'
require_relative '../lib/item_repository'

class ItemRepositoryTest < Minitest::Test
  def test_it_exists
    ir = ItemRepository.new("./data/items.csv")

    assert_instance_of ItemRepository, ir
  end

  def test_repo_pulls_in_CSV_info_from_items
    ir = ItemRepository.new("./data/items.csv")

    assert_equal 1367, ir.items_from_csv("./data/items.csv").count
  end

  def test_it_returns_array_of_all_items
    ir = ItemRepository.new("./data/items.csv")

    assert_equal 1367, ir.all.count
  end

  def test_find_by_id
    ir = ItemRepository.new("./data/items.csv")

    assert_instance_of Item, ir.find_by_id(263395237)
    assert_equal 263395237, ir.find_by_id(263395237).id
  end

  def test_it_can_find_by_name
    ir = ItemRepository.new("./data/items.csv")
    item_name = ir.find_by_name("Vogue Paris Original Givenchy 2307")

    assert_equal "Vogue Paris Original Givenchy 2307", item_name.name
  end

  def test_it_can_find_all_with_description
    ir = ItemRepository.new("./data/items.csv")
    item_des = ir.find_all_with_description("Acrylique sur toile et collage.")

    assert_instance_of Array, item_des
    assert_equal 1, item_des.count
  end

  def test_it_can_find_all_by_price
    ir = ItemRepository.new("./data/items.csv")
    item_price = ir.find_all_by_price(1.00)

    assert_instance_of Array, item_price
    assert_equal 4, item_price.count
    assert_equal 1.00, item_price[2].unit_price
  end

  def test_it_can_find_all_by_price_range
    ir = ItemRepository.new("./data/items.csv")
    item_range = ir.find_all_by_price_in_range(2.00..3.00)

    assert_instance_of Array, item_range
    assert_equal 38, item_range.count
  end

  def test_it_can_find_all_by_merchant_id
    ir = ItemRepository.new("./data/items.csv")
    mr = ir.find_all_by_merchant_id(12334213)
    assert_equal 2, mr.count

    merch = ir.find_all_by_merchant_id(12334105)
    assert_equal 3, merch.count
    assert_instance_of Array, ir.find_all_by_merchant_id(12334105)
  end
end
