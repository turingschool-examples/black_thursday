require_relative 'test_helper'
require_relative '../lib/item_repository'

class ItemRepositoryTest < Minitest::Test
  def setup
    @ir = ItemRepository.new
  end

  def test_it_exists
    @ir = ItemRepository.new
    assert_instance_of ItemRepository, @ir
  end

  def test_it_can_create_items_from_csv
    @ir.from_csv("./data/items.csv")
    # ("./test/fixtures/item_fixtures.csv")
    assert_equal 1367, @ir.items.count
    assert_instance_of Item, @ir.items[0]
    assert_instance_of Item, @ir.items[783]
    i = @ir.items
    binding.pry
    assert_instance_of Item, @ir.items[-1]


  end


end
