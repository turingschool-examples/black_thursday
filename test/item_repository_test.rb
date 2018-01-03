require_relative "test_helper"
require_relative "../lib/item_repository"

class ItemRepositoryTest < Minitest::Test

  def test_it_exists
    ir = ItemRepository.new("./test/test_data/test_items.csv")

    assert_instance_of ItemRepository, ir
  end

  def test_all_returns_array_of_all_items_in_file
    ir = ItemRepository.new("./test/test_data/test_items.csv")

    assert_instance_of Array, ir.all
    ir.all.each do |item|
      assert_instance_of Item, item
    end
    assert_equal "510+ RealPush Icon Set", ir.all[0].name
    assert_equal "263395237", ir.all[0].id
  end

  def test_find_by_id_returns_appropriate_item
    ir = ItemRepository.new("./test/test_data/test_items.csv")

    item = ir.find_by_id("263395237")
    unknown_item = ir.find_by_id("oogabooga")

    assert_nil unknown_item
    assert_equal "510+ RealPush Icon Set", item.name
  end

  def test_find_by_name_returns_appropriate_item
    ir = ItemRepository.new("./test/test_data/test_items.csv")

    item_1 = ir.find_by_name("Disney scrabble frames")
    item_2 = ir.find_by_name("DISNEY SCRABBLE framEs")
    unknown_item = ir.find_by_name("oogabooga")

    assert_nil unknown_item
    assert_equal "263395721", item_1.id
    assert_equal "263395721", item_2.id
  end

  def test_find_all_with_description_returns_array_of_appropriate_items
    ir = ItemRepository.new("./test/test_data/test_items.csv")

    items_1 = ir.find_all_with_description("excellent")
    items_2 = ir.find_all_with_description("the")
    items_2_ids = items_2.map { |item| item.id }
    unknown_item = ir.find_all_with_description("oogabooga")

    assert_equal [], unknown_item
    assert_equal "263395237", items_1[0].id
    assert_equal ["263395237", "263396209", "263396255", "263396517"], items_2_ids
  end

  def test_find_all_by_price_returns_array_of_appropriate_items
    ir = ItemRepository.new("./test/test_data/test_items.csv")
  end

  def test_find_all_by_price_in_range_returns_array_of_appropriate_items
    ir = ItemRepository.new("./test/test_data/test_items.csv")
  end

  def test_find_all_by_merchant_id_returns_array_of_appropriate_items
    ir = ItemRepository.new("./test/test_data/test_items.csv")

  end

end
