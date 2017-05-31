require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/item_repository'
#require './data/items.csv'

class ItemRepoTest < Minitest::Test

  def setup
    skip
    test = ItemRepository.new('items.csv')
  end

  def test_class_exits
    skip
    assert_instance_of ItemRepository, test
  end

end
