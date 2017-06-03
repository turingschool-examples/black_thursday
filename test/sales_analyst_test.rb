require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/sales_analyst'
require_relative '../lib/sales_engine'
require 'pry'

class SalesAnalystTest < Minitest::Test

  attr_reader :analyst,
              :analyst_2

  def setup
    item_dummy = CSV.open './test/data/small_item_set.csv', headers: true, header_converters: :symbol
    merch_dummy = CSV.open './test/data/merchant_sample.csv', headers: true, header_converters: :symbol
    engine  = SalesEngine.new(item_dummy, merch_dummy)
    @analyst = SalesAnalyst.new(engine)
    item_dummy_2 = CSV.open './test/data/medium_item_set.csv', headers: true, header_converters: :symbol
    merch_dummy_2 = CSV.open './test/data/medium_merchant_set.csv', headers: true, header_converters: :symbol
    engine_2  = SalesEngine.new(item_dummy_2, merch_dummy_2)
    @analyst_2 = SalesAnalyst.new(engine_2)
  end

  def test_sales_analyst_exists_and_knows_about_sales_engine
    assert_instance_of SalesAnalyst, analyst
    assert_instance_of SalesEngine, analyst.engine
  end

  def test_it_can_find_average_items_per_merchant
    assert_equal 1.2, analyst.average_items_per_merchant
    assert_equal 1.45, analyst_2.average_items_per_merchant
  end

  def test_it_can_calculate_standard_deviation_for_average_items_per_merchant
    item_dummy = CSV.open './data/items.csv', headers: true, header_converters: :symbol
    merch_dummy = CSV.open './data/merchants.csv', headers: true, header_converters: :symbol
    engine  = SalesEngine.new(item_dummy, merch_dummy)
    analyst_2 = SalesAnalyst.new(engine)


    assert_equal 3.26, analyst_2.average_items_per_merchant_standard_deviation
  end

  def test_it_knows_merchants_with_high_item_count
    actual = analyst_2.merchants_with_high_item_count

    assert_instance_of Array, actual
    assert_instance_of Merchant, actual.sample
  end

  def test_it_can_find_average_item_price_for_merchant
    actual = analyst_2.average_item_price_for_merchant(12334185)

    assert_instance_of BigDecimal, actual
    assert_equal 11.17, actual
  end

  def test_it_can_find_average_average_price_per_merchant
    actual = analyst_2.average_average_price_per_merchant

    assert_instance_of BigDecimal, actual
    assert_equal 6.66, actual
  end

  def test_it_can_find_golden_items
    actual = analyst_2.golden_items
    std_dev = analyst_2.average_item_price_standard_deviation

    assert_instance_of Array, actual
    assert_instance_of Item, actual.sample
    assert (actual.sample.unit_price - analyst_2.average_average_price_per_merchant) > (2 * std_dev)
  end

  def test_it_can_find_average_item_price
    actual = analyst_2.average_item_price

    assert_instance_of BigDecimal, actual
    assert_equal 183.20, actual
  end

  def test_it_knows_standard_deviation_of_average_average_item_price
    assert_equal 236.68, analyst_2.average_item_price_standard_deviation
  end
end
