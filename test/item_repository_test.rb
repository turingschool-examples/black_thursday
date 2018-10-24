require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require 'minitest/pride'
require './lib/item'
require './lib/item_repository'

class ItemRepositoryTest < Minitest::Test

  def test_it_exists
    ir = ItemRepository.new("./data/items.csv")

    assert_instance_of ItemRepository, ir
  end

  def test_all_returns_array_of_all_items
    ir = ItemRepository.new("./data/items.csv")
    binding.pry
    assert_instance_of Item, ir.all[0]
  end
end
