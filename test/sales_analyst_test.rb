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
    merchants = MerchantRepository.new("./data/merchants.csv")
    sa = SalesAnalyst.new(items, merchants)
    assert_instance_of SalesAnalyst, sa
  end

  def test_it_calculates_average_items_per_merchant
    items = ItemRepository.new("./data/items.csv")
    merchants = MerchantRepository.new("./data/merchants.csv")
    sa = SalesAnalyst.new(items, merchants)
    assert_equal 2.88, sa.average_items_per_merchant
  end

  def test_standard_deviation
    items = ItemRepository.new("./data/items.csv")
    merchants = MerchantRepository.new("./data/merchants.csv")
    sa = SalesAnalyst.new(items, merchants)
    assert_equal 3.26, sa.average_items_per_merchant_standard_deviation
  end

  def test_it_can_return_merchants_with_high_item_count
    items = ItemRepository.new("./data/items.csv")
    merchants = MerchantRepository.new("./data/merchants.csv")
    sa = SalesAnalyst.new(items, merchants)
#   binding.pry
    assert_equal 52, sa.merchants_with_high_item_count.length
  end

  def test_it_can_find_average_item_price_for_merchant
    items = ItemRepository.new("./data/items.csv")
    merchants = MerchantRepository.new("./data/merchants.csv")
    sa = SalesAnalyst.new(items, merchants)
    assert_equal 16.66, sa.average_item_price_for_merchant(12334105)
  end

  def test_it_can_average_average_price_per_merchant
    items = ItemRepository.new("./data/items.csv")
    merchants = MerchantRepository.new("./data/merchants.csv")
    sa = SalesAnalyst.new(items, merchants)
    assert_equal 350.29, sa.average_average_price_per_merchant
  end

  def test_golden_items_returns_array_of_items_2_stnd_devs_above_avg
    skip
    items = ItemRepository.new("./data/items.csv")
    merchants = MerchantRepository.new("./data/merchants.csv")
    sa = SalesAnalyst.new(items, merchants)
    assert_equal 5, sa.golden_items.count
    assert_instance_of Item, sa.golden_items[0]
  end

  def test_sums_adds_elements_of_array
    items = ItemRepository.new("./data/items.csv")
    merchants = MerchantRepository.new("./data/merchants.csv")
    sa = SalesAnalyst.new(items, merchants)
    array = [5, 6, 7, 8, 9, 10]
    assert_equal 45, sa.sums(array)
  end

  def test_variance_returns_sum_of_squared_differences
    items = ItemRepository.new("./data/items.csv")
    merchants = MerchantRepository.new("./data/merchants.csv")
    sa = SalesAnalyst.new(items, merchants)
    array = [5, 6, 7, 8, 9, 10]
    mean = 7.5
    assert_equal 17.5, sa.variance(array, mean)
  end

  def test_it_returns_standard_deviation
    items = ItemRepository.new("./data/items.csv")
    merchants = MerchantRepository.new("./data/merchants.csv")
    sa = SalesAnalyst.new(items, merchants)
    array = [5, 6, 7, 8, 9, 10]
    mean = 7.5
    assert_equal 1.87, sa.standard_deviation(array, mean)
  end

end
