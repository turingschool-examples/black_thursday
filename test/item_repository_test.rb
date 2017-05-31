require 'minitest/autorun'
require 'minitest/pride'
require './lib/item_repository'
require './lib/item'
require 'pry'


class ItemRepositoryTest < MiniTest::Test
  attr_reader :item_1,
              :item_2

  def setup
    @item_1 = Item.new(:id => 1,
                      :name => "Burger King",
                      :description => "Best burgers ever here",
                      :merchant_id => 123,
                      :unit_price => 15)
    @item_2 = Item.new(:id => 2,
                      :name => "McDonalds",
                      :description => "Best fries ever here",
                      :merchant_id => 124,
                      :unit_price => 10)
  end

  def test_has_no_merchants_when_initialized
    ir = ItemRepository.new

    assert_equal [], ir.all
  end

  def test_it_can_find_by_id
    ir = ItemRepository.new
    ir.add_items(item_1)

    assert_equal item_1, ir.find_by_id(1)
  end

  def test_if_can_find_by_name
    ir = ItemRepository.new
    ir.add_items(item_1)
    ir.add_items(item_2)

    assert_equal item_2, ir.find_by_name("McDonalds")
  end

  def test_to_find_all_with_description
    ir = ItemRepository.new
    ir.add_items(item_1)
    ir.add_items(item_2)
    results = ir.find_all_with_descriptions("Best burgers ever here")

    assert results.include?(item_1)
  end

  def test_if_can_find_all_by_price
    ir = ItemRepository.new
    ir.add_items(item_1)
    ir.add_items(item_2)
    results = ir.find_all_by_price(10)

    assert results.include?(item_2)
  end

  def test_if_can_find_all_by_price_in_range
    ir = ItemRepository.new
    ir.add_items(item_1)
    ir.add_items(item_2)
    results = ir.find_all_by_price_in_range(5..15)

    assert results.include?(item_1)
    assert results.include?(item_2)
  end

  def test_if_can_find_all_by_merchant_id
    ir = ItemRepository.new
    ir.add_items(item_1)
    ir.add_items(item_2)
    results = ir.find_all_by_merchant_id(123)

    assert results.include?(item_1)
  end

end
