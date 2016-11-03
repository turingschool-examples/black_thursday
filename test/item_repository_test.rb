require_relative 'test_helper'
require_relative '../lib/item_repository'

class ItemRepositoryTest < Minitest::Test

  attr_reader :item_repository

  def setup
    file = "./test/data_fixtures/items_fixture.csv"
    @item_repository = ItemRepository.new(file)
  end

  def test_all_returns_an_array_of_item_instances
    assert_kind_of Array, item_repository.all
  end

  def test_all_returns_an_array_of_all_item_objects
    item_repository.all.each {|item| assert_kind_of Item, item}
  end

  def test_all_includes_all_25_item_objects_from_items_fixture
    assert_equal 25, item_repository.all.length
  end

  def test_find_by_id_returns_item_instance_with_matching_id
    id = 263395617
    item = item_repository.find_by_id(id)
    assert_kind_of Item, item
    assert_equal id, item.id
  end

  def test_find_by_id_without_match_returns_nil
    id = 99999999
    assert_nil item_repository.find_by_id(id)
  end

  def test_find_by_name_returns_item_instance_with_matching_name
    name = '510+ RealPush Icon Set'
    item = item_repository.find_by_name(name)
    assert_kind_of Item, item
    assert_equal name, item.name
  end

  def test_find_by_name_returns_instance_with_matching_name_all_caps
    name_upcase = '510+ REALPUSH ICON SET'
    name = '510+ RealPush Icon Set'
    item = item_repository.find_by_name(name_upcase)
    assert_equal name, item.name
  end

  def test_find_by_name_without_match_returns_nil
    name = '1000-count lot Gary Busey framed portraits'
    assert_nil item_repository.find_by_name(name)
  end

  def test_find_all_with_description_without_match_returns_empty_array
    description = 'highlyunlikelydescriptionfragment'
    items = item_repository.find_all_with_description(description)
    assert_equal [], items
  end

  def test_find_all_with_description_returns_array_of_all_matching_items
    description = 'scrabble'
    items = item_repository.find_all_with_description(description)
    assert items.one? {|item| item.name == "Glitter scrabble frames"}
    assert items.one? {|item| item.name == "Disney scrabble frames"}
  end

  def test_find_all_by_price_returns_one_instance_with_exact_price_match
    unit_price = BigDecimal(13.00,4)
    items = item_repository.find_all_by_price(unit_price)
    assert items.one? {|item| item.name == "Glitter scrabble frames"}
    assert_equal 1, items.length
  end

  def test_find_all_by_price_without_match_returns_nil
    unit_price = BigDecimal(0)
    items = item_repository.find_all_by_price(unit_price)
    assert_equal [], items
  end 

  def test_find_all_by_price_with_multiple_matches_returns_multiple_items
    unit_price = BigDecimal(500)
    items = item_repository.find_all_by_price(unit_price)
    assert_equal 2, items.length
  end 

  def test_find_all_by_merchant_id_returns_one_instance_of_merchant
    merchant_id = 12334141
    items = item_repository.find_all_by_merchant_id(merchant_id)
    assert_equal 1, items.length
    assert items.one? {|item| item.id == 263395237}
  end

  def test_find_all_by_merchant_without_match_returns_nil
    merchant_id = 99999999
    items = item_repository.find_all_by_merchant_id(merchant_id)
    assert_equal [], items
  end

  def test_find_all_by_merchant_with_multiple_matches_returns_multiple_items
    merchant_id = 12334195
    items = item_repository.find_all_by_merchant_id(merchant_id)
    assert_equal 10, items.length
  end

  def test_find_all_by_price_in_range_returns_one_price
    price_range = (0..6)
    items = item_repository.find_all_by_price_in_range(price_range)
    assert_equal 1, items.length
    assert items.one? {|item| item.id == 263397163}
  end

  def test_find_all_by_price_in_range_returns_empty_array
    price_range = (0..0)
    items = item_repository.find_all_by_price_in_range(price_range)
    assert_equal [], items
  end

  def test_find_all_by_price_in_range_with_multiple_matches_returns_multiple_items
    price_range = (0..10)
    items = item_repository.find_all_by_price_in_range(price_range)
    assert_equal 3, items.length
  end

end