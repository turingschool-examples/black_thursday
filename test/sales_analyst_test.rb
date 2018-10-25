require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require 'minitest/pride'
require './lib/sales_analyst'
require './lib/merchant_repository'
require './lib/item_repository'


class SalesAnalystTest < Minitest::Test

  def test_it_exists
    items = ItemRepository.new("./data/items.csv")
    sa = SalesAnalyst.new(items)

    assert_instance_of SalesAnalyst, sa
  end

  def test_it_calculates_average_items_per_merchant
    items = ItemRepository.new("./data/items.csv")
    sa = SalesAnalyst.new(items)
    assert_equal 2.88, sa.average_items_per_merchant
  end

  def test_standard_deviation
    items = ItemRepository.new("./data/items.csv")
    sa = SalesAnalyst.new(items)
    assert_equal 3.26, sa.standard_deviation
  end

end
