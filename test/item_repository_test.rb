gem 'minitest', '~> 5.2'
require 'minitest/autorun'
require 'minitest/pride'
require_relative "../lib/item_repository"
require 'csv'


class ItemRepositoryTest < MiniTest::Test
  attr_reader :item_repository
  def setup
    @item_repository = ItemRepository.new("./data/items.csv")
  end
  def test_it_maker_polulates_all_with_instances_of_item
    assert_instance_of Item, item_repository.all.first
    assert_equal 1367, item_repository.all.length
  end
  def test_empty_id_returns_nil #sad test
    assert_equal nil, item_repository.find_by_id("not_a_valid_id")
    assert_equal nil, item_repository.find_by_id(666)
  end

end
