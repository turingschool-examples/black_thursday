require './lib/item_repository'
require './lib/sales_engine'
require 'csv'
require 'minitest/autorun'
require 'minitest/emoji'

class ItemRepositoryTest < Minitest::Test

  def setup
    @se = SalesEngine.new({
          :items     => "./data/items.csv",
          :merchants => "./data/merchants.csv",
          })
    @ir = @se.item
  end

  def test_it_exists
    assert_instance_of ItemRepository, @ir
  end

  def test_it_can_return_array_of_known_merchant_instances
    assert_equal 1367, @ir.all.count
  end

end
