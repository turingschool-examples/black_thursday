require_relative 'test_helper'
require_relative '../lib/item_repository'

class ItemRepositoryTest < MiniTest::Test
  def setup
    file_path = './test/fixtures/items_truncated.csv'
    @ir = ItemRepository.from_csv(file_path, mock('SalesEngine'))
  end

  def test_all_returns_an_array_of_item_instances
    items = @ir.all

    assert_equal 18, items.length
    assert items.all? do |element|
      element.class == Item
    end
  end

  def test_find_by_id_returns_nil_if_item_does_not_exist
    assert_nil @ir.find_by_id(789)
  end

  def test_find_by_id_returns_item_instance_with_matching_id
    item = @ir.find_by_id(263396209)

    assert_equal 263396209, item.id
    assert_instance_of Item, item
  end

  def test_find_by_name_returns_nil_if_item_does_not_exist
    assert_nil @ir.find_by_name('bill robbins')
  end

  def test_find_by_name_returns_item_instance_with_matching_name
    item = @ir.find_by_name('Disney scrabble frames')

    assert_equal 'Disney scrabble frames', item.name
    assert_instance_of Item, item
  end

  def test_find_by_name_returns_item_instance_with_matching_name_case_insensitive
    item = @ir.find_by_name('disney scrabble frames')

    assert_equal 'Disney scrabble frames', item.name
  end

  def test_find_all_with_description_returns_all_items_with_a_matching_description
    description = 'french bulldog'

    items = @ir.find_all_with_description(description)

    assert_equal 2, items.count
    assert items.all? do |item|
      item.description == description
    end
  end

  def test_find_all_with_description_returns_all_items_with_a_matching_description_case_insensitive
    description = 'french bulldog'

    items = @ir.find_all_with_description(description)

    assert_equal 2, items.length
    assert items.all? do |item|
      item.description == description
    end
  end

  def test_find_all_with_description_returns_an_empty_array_if_no_items_match_description
    description  = 'You can use it to knit'

    items = @ir.find_all_with_description(description)

    assert items.empty?
  end

  def test_find_by_price_returns_all_items_with_a_matching_price
    price = 13.00

    items = @ir.find_all_by_price(price)

    assert_equal 3, items.count
    assert items.all? do |item|
      item.unit_price_in_dollars == price
    end
  end

  def test_find_by_price_returns_an_empty_array_if_no_items_match_price
    price = 0.06

    items = @ir.find_all_by_price(price)

    assert items.empty?
  end

  def test_find_all_by_price_in_range_returns_all_items_within_a_price_range
    price_range = (10.99..20.99)

    items = @ir.find_all_by_price_in_range(price_range)

    assert_equal 7, items.count
    assert items.all? do |item|
      item.price_in_range == price_in_range
    end
  end

  def test_find_all_by_price_in_range_returns_an_empty_array_if_no_items_are_within_price_range
    price_range = (0.05..0.06)

    items = @ir.find_all_by_price_in_range(price_range)

    assert items.empty?
  end

  def test_find_all_by_merchant_id_returns_all_items_with_a_matching_merchant_id
    merchant_id = 12334185

    items = @ir.find_all_by_merchant_id(merchant_id)

    assert_equal 4, items.count
    assert items.all? do |item|
      item.merchant_id == merchant_id
    end
  end

  def test_find_all_by_merchant_id_returns_an_empty_array_if_no_items_match_merchant_id
    merchant_id = 453

    items = @ir.find_all_by_merchant_id(merchant_id)

    assert items.empty?
  end
end
