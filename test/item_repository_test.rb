require_relative 'test_helper.rb'
require_relative '../lib/item_repository.rb'
require_relative '../lib/item.rb'

class ItemRepostoryTest < Minitest::Test
  attr_accessor :items

  def setup
    @items = ItemRepository.new('data/items.csv')
  end

  def test_item_repository_exists
    assert_instance_of ItemRepository, items
  end

  def test_returns_array_of_all_item_instances
    assert_equal 1367, items.all.length
  end

  def test_find_by_id_returns_item_with_id
    expected = items.find_by_id(263400305)

    assert_equal 263400305, expected.id
    assert_instance_of Item, expected
  end

  def test_find_by_id_returns_nil_if_no_match
    expected = items.find_by_id(65432546)

    assert_nil expected
  end

  def test_find_by_name_returns_instance_of_item
    expected = items.find_by_name('Harris - Cinnamon Buns')

    assert_equal "Harris - Cinnamon Buns", expected.name
    assert_instance_of Item, expected
  end

  def test_find_all_with_description_returns_item_with_description_match
    expected = items.find_all_with_description("I have sizes S, M, and L")

    assert_instance_of Array, expected
    assert_equal 1, expected.count
  end

  def test_find_all_with_description_returns_empty_when_no_match_found
    expected = items.find_all_with_description("doggo")

    assert_equal [], expected
  end

  def test_find_all_by_price_returns_items_with_two_integer_price_match
    expected = items.find_all_by_price(19)

    assert_instance_of Array, expected
    assert_equal 17, expected.count
  end

  def test_find_all_by_price_returns_items_with_dollar_price_match
    expected = items.find_all_by_price(19.00)

    assert_instance_of Array, expected
    assert_equal 17, expected.count
  end

  def test_find_all_by_price_returns_empty_array_when_no_match_found
    expected = items.find_all_by_price(17.38)

    assert_equal [], expected
  end

  def test_find_all_by_price_in_range_returns_array_of_price_matches_within_range
    expected = items.find_all_by_price_in_range(10.00..150.00)

    assert_instance_of Array, expected
    assert_equal 910, expected.count
  end

  def test_find_all_by_merchant_id_returns_item_matching_merchant_id
    expected = items.find_all_by_merchant_id(12334326)

    assert_instance_of Array, expected
    assert_equal 6, expected.count
  end

  def test_find_all_by_merchant_id_returns_empty_if_no_match_found
    expected = items.find_all_by_merchant_id(001011010110110)

    assert_equal [], expected
  end
end
