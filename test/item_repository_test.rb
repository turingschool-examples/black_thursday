require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/item_repository'
#require './data/items.csv'

class ItemRepoTest < Minitest::Test

  def test_class_exists
    result = ItemRepository.new(['a', 'b'])
    assert_instance_of ItemRepository, result
  end

  def test_items
    new_instance = ItemRepository.new(['a', 'b'])
    result = new_instance.items.length
    assert_equal 2, result
  end

  def test_items_again
    new_instance = ItemRepository.new(['a', 'b', 'c'])
    result = new_instance.items.length
    assert_equal 3, result
  end

  def test_items_otro_vez
    new_instance = ItemRepository.new(['a', 'b', 'c', 'd', 'e'])
    result = new_instance.items.length
    assert_equal 5, result
  end

end
