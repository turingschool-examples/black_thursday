require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/sales_analyst'

class SalesAnalystTest < Minitest::Test

  attr_reader :sales_analyst

  def setup
    sales_engine = SalesEngine.from_csv({
      :items => "./data_fixtures/items_fixture.csv",
      :merchants => "./data_fixtures/merchants_fixture.csv"
    })
    @sales_analyst = SalesAnalyst.new(sales_engine)
  end
  
  def test_sales_analyst_exists
    assert sales_analyst
  end

  def test_calculates_average_items_per_merchant
    assert_equal 1.25, sales_analyst.average_items_per_merchant
  end

  def test_calculates_average_items_per_merchant_standard_deviation
    assert_equal 2.01, sales_analyst.average_items_per_merchant_standard_deviation
  end

  def test_merchants_with_high_item_count_returns_merchants_above_one_st_dev_in_item_count
    skip
    top_merchants = sales_analyst.merchants_with_high_item_count
    puts top_merchants.inspect
    assert_equal 1, top_merchants.length
    assert top_merchants.one? {|merchant| merchant.id == 12334195}
    assert top_merchants.all? {|merchant| merchant.items.length > 3}
  end


end