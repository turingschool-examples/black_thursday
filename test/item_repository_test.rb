require_relative 'test_helper'
require_relative '../lib/item_repository'

class ItemRepositoryTest < MiniTest::Test
  def setup
    file_path = './test/fixtures/items_truncated.csv'
    @ir = ItemRepository.new(file_path, mock('SalesEngine'))
  end

  def test_all_returns_an_array_of_item_instances
    items = @ir.all

    all_items = items.all? do |element|
      element.class == Item
    end

    assert_equal 34, items.length
    assert all_items
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
    item = @ir.find_by_name('Glitter scrabble frames')

    assert_equal 'Glitter scrabble frames', item.name
    assert_instance_of Item, item
  end

  def test_find_by_name_returns_item_instance_with_matching_name_case_insensitive
    item = @ir.find_by_name('glitter scrabble Frames')

    assert_equal 'Glitter scrabble frames', item.name
  end

  def test_find_all_with_description_returns_all_items_with_a_matching_description
    description = 'french bulldog'

    items = @ir.find_all_with_description(description)

    all_match_description = items.all? do |item|
      item.description.downcase.include?(description)
    end

    assert_equal 4, items.count
    assert all_match_description
  end

  def test_find_all_with_description_returns_all_items_with_a_matching_description_case_insensitive
    description = 'French buLldog'

    items = @ir.find_all_with_description(description)

    all_match_description = items.all? do |item|
      item.description.downcase.include?(description.downcase)
    end

    assert_equal 4, items.length
    assert all_match_description
  end

  def test_find_all_with_description_returns_an_empty_array_if_no_items_match_description
    description  = 'You can use it to knit'

    items = @ir.find_all_with_description(description)

    assert items.empty?
  end

  def test_find_by_price_returns_all_items_with_a_matching_price
    price = 13.00

    items = @ir.find_all_by_price(price)

    all_match_price = items.all? do |item|
      item.unit_price_in_dollars == price
    end

    assert_equal 4, items.count
    assert all_match_price
  end

  def test_find_by_price_returns_an_empty_array_if_no_items_match_price
    price = 0.06

    items = @ir.find_all_by_price(price)

    assert items.empty?
  end

  def test_find_all_by_price_in_range_returns_all_items_within_a_price_range
    price_range = (10.99..20.99)

    items = @ir.find_all_by_price_in_range(price_range)

    all_in_range = items.all? do |item|
      price_range.cover?(item.unit_price_in_dollars)
    end

    assert_equal 12, items.count
    assert all_in_range
  end

  def test_find_all_by_price_in_range_returns_an_empty_array_if_no_items_are_within_price_range
    price_range = (0.05..0.06)

    items = @ir.find_all_by_price_in_range(price_range)

    assert items.empty?
  end

  def test_find_all_by_merchant_id_returns_all_items_with_a_matching_merchant_id
    merchant_id = 12334185

    items = @ir.find_all_by_merchant_id(merchant_id)
    all_match_merchant = items.all? do |item|
      item.merchant_id == merchant_id
    end

    assert_equal 6, items.count
    assert all_match_merchant
  end

  def test_find_all_by_merchant_id_returns_an_empty_array_if_no_items_match_merchant_id
    merchant_id = 453

    items = @ir.find_all_by_merchant_id(merchant_id)

    assert items.empty?
  end
end
