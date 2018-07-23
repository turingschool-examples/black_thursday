require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/item_repository.rb'
require_relative '../lib/item.rb'
require_relative '../lib/sales_engine.rb'

class ItemRepositoryTest < Minitest::Test
  def test_it_exists
    se = SalesEngine.from_csv({
    :items     => "./data/items.csv",
    :merchants => "./data/merchants.csv",
     })
     ir   = se.items
    assert_instance_of ItemRepository, ir
  end





end
