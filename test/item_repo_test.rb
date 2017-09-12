require 'minitest/autorun'
require 'minitest/pride'
require './lib/item_repo'
require 'pry'

class ItemRepoTest < MiniTest::Test

  def test_it_exists
    ir = ItemRepo.new("./data/items.csv")

    assert_instance_of ItemRepo, ir
  end

  def test_all_returns_array_of_all_items
    items = ItemRepo.new("./data/items.csv")

    assert_equal 1367, items.all.count
  end

  def test_find_by_id_returns_matching_id
    items = ItemRepo.new("./data/items.csv")
    expected = "Linnen Tafelkleed &#39;Non posso vivere di vento&#39;"

    assert_equal expected, items.find_by_id("263405559").name
  end

  def test_find_by_id_returns_nil_if_no_match
    items = ItemRepo.new("./data/items.csv")

    assert_nil items.find_by_id("xxxxxxxx")
  end

  def test_find_all_with_description_returns_all_with_match
    items = ItemRepo.new("./data/items.csv")

    assert_equal 706, items.find_all_with_description("the").count
    assert_equal 706, items.find_all_with_description("THE").count
  end

  def test_find_all_with_description_returns_empty_array_if_no_match
    items = ItemRepo.new("./data/items.csv")

    assert_equal [], items.find_all_with_description("xxxxxxxxx")
  end

  def test_find_all_by_price_returns_all_matches_with_exact_price

  end
end
