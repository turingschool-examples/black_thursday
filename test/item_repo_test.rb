require 'minitest/autorun'
require 'minitest/pride'
require './lib/sales_engine'
require './lib/merchant_repo'
require './lib/item_repo'
require './lib/item'
require './lib/merchant'

class ItemRepoTest < Minitest::Test

  def test_create_an_item_repo_instance
    se = SalesEngine.from_csv({
                              :items     => "./data/items.csv",
                              :merchants => "./data/merchants.csv"
                              })
    ir   = se.items
    assert_instance_of ItemRepo, ir
  end

  def test_can_return_all_items
    se = SalesEngine.from_csv({
                              :items     => "./data/items.csv",
                              :merchants => "./data/merchants.csv"
                              })
    ir   = se.items
    assert_equal ir.item_list, ir.all
  end
end
