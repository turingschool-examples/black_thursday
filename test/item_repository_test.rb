require "minitest/autorun"
require "minitest/pride"
require "csv"
require_relative "../lib/item_repository"
require "pry"

class ItemRepositoryTest < Minitest::Test
  attr_reader :item_repo
  def setup
    csv = CSV.open('./data/small_item_set.csv', :headers => true, :header_converters => :symbol)
    @item_repo = ItemRepository.new(csv)
  end

  def test_it_exists_and_populates_items_automatically
    assert_instance_of ItemRepository, item_repo
    assert_instance_of Item, item_repo.items[item_repo.items.keys.sample]
    assert_equal 5, item_repo.items.keys.length
  end

  def test_it_can_add_items
    csv = CSV.open('./data/small_item_set.csv', :headers => true, :header_converters => :symbol)

    item_repo.items.clear

    item_repo.add(csv)
    random_item_key = item_repo.items.keys.sample

    assert_instance_of Item, item_repo.items[random_item_key]
    assert_equal 5, item_repo.items.keys.length
  end

  def test_it_can_return_all_item_instances
    actual = item_repo.all
    assert_equal 5, actual.length
    assert_instance_of Item, actual[0]
  end
end
