require "./test/test_helper"
require "./lib/sales_engine"
require "./lib/item_repository"
require "./lib/item"

class ItemRepositoryTest < Minitest::Test

  attr_reader :item_repository

  def setup
    item_csv = "./test/test_fixtures/items_short.csv"
    @item_repository = ItemRepository.new("fake_se", item_csv)
  end

  def test_it_exists
    assert_instance_of ItemRepository, item_repository
  end

  def test_it_makes_array_of_all_items
    assert_instance_of Array, item_repository.all
    assert_instance_of Item, item_repository.all[0]
  end

  def test_it_returns_nil_for_invalid_id
    assert_nil item_repository.find_by_id(173)
  end

  def test_it_returns_item_instance_for_id
    assert_instance_of Item, item_repository.find_by_id(263395237)
  end

  def test_it_returns_nil_for_invalid_name
    assert_nil  item_repository.find_by_name("floof")
  end

  def test_it_returns_item_instance_for_name
    assert_instance_of Item, item_repository.find_by_name("Glitter scrabble frames")
  end

  def test_it_returns_array_with_items_matching_description
    assert_instance_of Array, item_repository.find_all_with_description("Blue")
    assert_instance_of Item, item_repository.find_all_with_description("Blue")[0]
  end

  def test_it_returns_empty_array_if_no_description_match
    assert_equal [], item_repository.find_all_with_description("chunky blender kittens")
  end

  def test_it_returns_item_instances_with_items_of_same_price
    assert_instance_of Item,  item_repository.find_all_by_price(BigDecimal.new(12))[0]
  end

  def test_it_returns_empty_array_if_no_price_match
    assert_equal [], item_repository.find_all_by_price(-2)
  end

  def test_it_returns_array_with_items_of_price_in_range
    assert_instance_of Array, item_repository.find_all_by_price_in_range(11..13)
    assert_instance_of Item, item_repository.find_all_by_price_in_range(11..13)[0]
  end

  def test_it_returns_empty_array_if_no_price_range_match
    assert_equal [], item_repository.find_all_by_price_in_range(-2..-1)
  end

  def test_it_returns_item_instance_for_merchant_id
    assert_equal [], item_repository.find_all_by_merchant_id(1234)
  end

  def test_it_returns_item_instance_for_merchant_id
      assert_instance_of Item, item_repository.find_all_by_merchant_id(12334141)[0]
  end

  def test_inspect
    assert_instance_of String, item_repository.inspect
  end

end
