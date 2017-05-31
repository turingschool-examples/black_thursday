require 'minitest/autorun'
require 'minitest/pride'
require './lib/item_repository'
require './lib/item'
require 'pry'


class ItemRepositoryTest < MiniTest::Test

  def test_has_no_merchants_when_initialized
    item = ItemRepository.new

    assert_equal [], item.all
  end

  def test_it_can_find_by_id
    item = ItemRepository.new
    item_1 = Item.new(:id => 1,
                      :name => "Burger King",
                      :description => "Best burgers ever here", :merchant_id => 123)
    item_2 = Item.new(:id => 2,
                      :name => "McDonalds",
                      :description => "Best fries ever here", :merchant_id => 124)
    item.add_items(item_1)

    assert_equal item_1, item.find_by_id(1)
  end

  def test_if_can_find_by_name
    item = ItemRepository.new
    item_1 = Item.new(:id => 1,
                      :name => "Burger King",
                      :description => "Best burgers ever here", :merchant_id => 123)
    item_2 = Item.new(:id => 2,
                      :name => "McDonalds",
                      :description => "Best fries ever here", :merchant_id => 124)
    item.add_items(item_1)
    item.add_items(item_2)

    assert_equal item_2, item.find_by_name("McDonalds")
  end

  def test_to_find_all_with_description
    item = ItemRepository.new

    assert_equal [], item.find_all_with_descriptions
  end

  def test_if_can_find_all_by_price
    item = ItemRepository.new

    assert_equal [], item.find_all_by_price
  end

  def test_if_can_find_all_by_price_in_range
    item = ItemRepository.new

    assert_equal [], item.find_all_by_price_in_range
  end

  def test_if_can_find_all_by_merchant_id
    item = ItemRepository.new

    assert_equal [], item.find_all_by_merchant_id
  end

end
