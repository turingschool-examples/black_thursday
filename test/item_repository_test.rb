require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/item_repository'

class ItemRepositoryTest < Minitest::Test
  def test_exists
    item_repo = ItemRepository.new('./test/items.csv')
    assert_instance_of ItemRepository, item_repo
  end

  def test_can_load_item
    item_repo = ItemRepository.new('./test/items.csv')
    assert_instance_of Array, item_repo.items
    assert_equal 263395237, item_repo.items.first.id
    assert_equal "2016-01-11 09:34:06 UTC", item_repo.items.first.created_at
  end

  def test_it_loads_items
    item_repo = ItemRepository.new('./test/items.csv')

    assert item_repo.all.all? {|item|item.kind_of?(Item)}
    assert_equal 1367, item_repo.all.count
  end

  def test_it_can_find_by_id
    item_repo = ItemRepository.new('./test/items.csv')

    result = item_repo.find_by_id(263395237)
    assert_instance_of Item, result
    assert_equal "510+ RealPush Icon Set", result.name
  end

  def test_it_can_return_nil_if_no_id_matched
    item_repo = ItemRepository.new('./test/items.csv')

    result = item_repo.find_by_id(0000000)
    assert_nil result
  end

  def test_it_can_fiind_by_name
    item_repo = ItemRepository.new('./test/items.csv')

    result = item_repo.find_by_name("510+ realPush Icon Set")

    assert_equal 263395237, result.id
  end

  def test_it_can_find_all_by_description
    item_repo = ItemRepository.new('./test/items.csv')

    result = item_repo.find_all_with_description("Disney")
    assert_instance_of Array, result
    assert result.all? {|item|item.is_a?(Item)}
    assert_equal 263395721, result.first.id
  end

  def test_it_can_retun_empty_array_when_no_description_matched
    item_repo = ItemRepository.new('./test/items.csv')

    result = item_repo.find_all_with_description("manoj")
    assert_equal [], result
  end

  def test_find_all_by_price_method_return_instance_of_item
    item_repo = ItemRepository.new('./test/items.csv')
    result = item_repo.find_all_by_price(1300)

    assert_instance_of Array, result
    assert result.all? {|item|item.is_a?(Item)}

    assert_equal 8, result.count
  end

  def test_it_can_

end
