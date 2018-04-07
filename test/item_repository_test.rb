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

  def test_it_can_create_items
    # binding.pry
    rows = @ir.from_csv("./data/items.csv")
    # ("./test/fixtures/item_fixtures.csv")
    assert_equal "", rows
  end
end
