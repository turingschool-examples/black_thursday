require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/sales_analyst'
require_relative '../lib/sales_engine'
require 'pry'

class SalesAnalystTest < Minitest::Test

  attr_reader :analyst

  def setup
    item_dummy = CSV.open './test/data/small_item_set.csv', headers: true, header_converters: :symbol
    merch_dummy = CSV.open './test/data/merchant_sample.csv', headers: true, header_converters: :symbol
    engine  = SalesEngine.new(item_dummy, merch_dummy)
    @analyst = SalesAnalyst.new(engine)
  end

  def test_sales_analyst_exists_and_knows_about_sales_engine
    assert_instance_of SalesAnalyst, analyst
    assert_instance_of SalesEngine, analyst.engine
  end

  def test_it_can_find_average_items_per_merchant
    item_dummy = CSV.open './test/data/medium_item_set.csv', headers: true, header_converters: :symbol
    merch_dummy = CSV.open './test/data/medium_merchant_set.csv', headers: true, header_converters: :symbol
    engine  = SalesEngine.new(item_dummy, merch_dummy)
    analyst_2 = SalesAnalyst.new(engine)

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
    item_dummy = CSV.open './test/data/medium_item_set.csv', headers: true, header_converters: :symbol
    merch_dummy = CSV.open './test/data/medium_merchant_set.csv', headers: true, header_converters: :symbol
    engine  = SalesEngine.new(item_dummy, merch_dummy)
    analyst_2 = SalesAnalyst.new(engine)

    actual = analyst_2.merchants_with_high_item_count

    assert_instance_of Array, actual
    assert_instance_of Merchant, actual.sample
  end
end
