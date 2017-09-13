require "./test/test_helper"
require "./lib/sales_engine"
require "./lib/item_repository"
require './lib/item'

class ItemRepositoryTest < Minitest::Test

  attr_reader :item_repo

  def setup
    item_csv = "./test/test_data/items_short.csv"
    @item_repo = ItemRepository.new('fake_se', item_csv)
  end

  def test_it_exists
    assert_instance_of ItemRepository, item_repo
  end

  def test_items_short
    assert_instance_of Array, item_repo.all
  end

  def test_it_returns_nil_for_invalid_id
    assert_nil  item_repo.find_by_id(1234)
  end

  def test_it_returns_merchant_instance_for_id
    assert_instance_of Item, item_repo.find_by_id(263395237)
  end

  def test_it_returns_nil_for_invalid_name
    assert_nil  item_repo.find_by_name("floof")
  end

  def test_it_returns_merchant_instance_for_name
    assert_instance_of Item, item_repo.find_by_name("Glitter scrabble frames")
  end

  def test_it_returns_array_with_items_matching_description
    assert_instance_of Array, item_repo.find_all_with_description("Blue")
  end

  def test_it_returns_empty_array_if_no_description_match
    assert_equal [], item_repo.find_all_with_description("chunky blender kittens")
  end

end
