require 'minitest/autorun'
require 'minitest/pride'
require './lib/item_repository'
require 'pry'


class ItemRepositoryTest < MiniTest::Test

  def test_can_call_all_on_merchants
    item = ItemRepository.new

    assert_equal [], item.all
  end

  def test_it_can_find_by_id
    item = ItemRepository.new

    assert_equal nil, item.find_by_id
  end

  def test_if_can_find_by_name
    item = ItemRepository.new

    assert_equal nil, item.find_by_name
  end

  def test_to_find_all_with_description
    item = ItemRepository.new

    assert_equal [], item.find_all_with_descriptions
  end

  def test_if_can_find_all_by_price
    item = ItemRepository.new

    assert_equal [], item.find_all_by_price
  end


end
