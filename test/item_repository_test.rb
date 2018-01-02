require './test/test_helper'
require './lib/item_repository'

class ItemRepositoryTest < MiniTest::Test
  def test_all_returns_an_array_of_item_instances
    ir = ItemRepository.new('./data/items.csv')

    result = ir.all

    assert result.all? do |element|
      element.class == Item
    end
  end

  def test_find_by_id_returns_nil_if_item_does_not_exist
    ir = ItemRepository.new('./data/items.csv')

    assert nil, ir.find_by_id(789)
  end

  def test_find_by_id_returns_item_instance_with_matching_id
    ir = ItemRepository.new('./data/items.csv')

    result = ir.find_by_id(568)

    assert_equal 568, result.id
    assert_instance_of Item, result
  end

  def test_find_by_name_returns_nil_if_item_does_not_exist
    ir = ItemRepository.new('./data/items.csv')

    assert nil, ir.find_by_name('bill robbins')
  end

  def test_find_by_name_returns_item_instance_with_matching_name
    ir = ItemRepository.new('./data/items.csv')

    result = ir.find_by_names('pencil')

    assert_equal 'pencil', result.name
    assert_instance_of Item, result
  end

  def test_find_all_with_description_returns_all_items_with_a_matching_description
    ir = ItemRepository.new('./data/items.csv')
    description = 'You can use it to write things'

    result = ir.find_all_with_description(description)

    assert result.all? do |item|
      item.description == description
    end
  end

  def test_find_all_with_description_returns_an_empty_array_if_no_items_match_description
    ir = ItemRepository.new('./data/items.csv')
    name = 'You can use it to knit'

    result = ir.find_all_with_description(description)

    assert result.empty?
  end

  def test_find_by_price_returns_all_items_with_a_matching_price
    ir = ItemRepository.new('./data/items.csv')
    price = 10.99

    result = ir.find_by_price(price)

    assert result.all? do |item|
      item.price == price
    end
  end

  def test_find_by_price_returns_an_empty_array_if_no_items_match_price
    ir = ItemRepository.new('./data/items.csv')
    name = 0.06

    result = ir.find_by_price(price)

    assert result.empty?
  end

  def test_find_all_by_price_in_range_returns_all_items_within_a_price_range
    ir = ItemRepository.new('./data/items.csv')
    price_range = (10.99..20.99)

    result = ir.find_all_by_price_in_range(price_range)

    assert result.all? do |item|
      item.price_in_range == price_in_range
    end
  end

  def test_find_all_by_price_in_range_returns_an_empty_array_if_no_items_are_within_price_range
    ir = ItemRepository.new('./data/items.csv')
    price_range = (0.05..0.06)

    result = ir.find_all_by_price_in_range(price_range)

    assert result.empty?
  end

  def test_find_all_by_merchant_id_returns_all_items_with_a_matching_merchant_id
    ir = ItemRepository.new('./data/items.csv')
    merchant_id = 674

    result = ir.find_all_by_merchant_id(merchant_id)

    assert result.all? do |item|
      item.merchant_id == merchant_id
    end
  end

  def test_find_all_by_merchant_id_returns_an_empty_array_if_no_items_match_merchant_id
    ir = ItemRepository.new('./data/items.csv')
    name = 453

    result = ir.find_all_by_merchant_id(merchant_id)

    assert result.empty?
  end
end
