require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require 'minitest/pride'
require './lib/sales_analyst'
require './lib/merchant_repository'
require './lib/item_repository'
require 'bigdecimal'


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

  def test_it_can_return_merchants_with_high_item_count
    items = ItemRepository.new("./data/items.csv")
    sa = SalesAnalyst.new(items)
    assert_equal 52, sa.merchants_with_high_item_count.length
  end

  def test_it_can_find_average_item_price_for_merchant
    items = ItemRepository.new("./data/items.csv")
    sa = SalesAnalyst.new(items)
    assert_equal 16.66, sa.average_item_price_for_merchant(12334105)
  end

  def test_it_can_average_average_price_per_merchant
    items = ItemRepository.new("./data/items.csv")
    sa = SalesAnalyst.new(items)
    assert_equal 350.29, sa..average_average_price_per_merchant
  end

end
