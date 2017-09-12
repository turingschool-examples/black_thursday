require 'minitest/autorun'
require 'minitest/pride'
require './lib/item_repository'
require 'pry'

class ItemRepositoryTest < Minitest::Test

  attr_reader :ir

  def setup
    @ir = ItemRepository.new('./data/items_test.csv')
  end

  def test_it_exists
    assert_instance_of ItemRepository, @ir
  end

end
