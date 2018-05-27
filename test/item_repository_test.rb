require_relative 'test_helper'
require './lib/sales_engine'
require './lib/item_repository'

class ItemRepositoryTest < Minitest::Test

  def setup
    @se = SalesEngine.new({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      })
  end

  def test_it_exists
    assert_instance_of ItemRepository, @se.items
  end

  def test_it_can_return_all_items
    assert_equal 1367, @se.items.all.count
  end

  def test_it_finds_an_item_by_id

end
