require 'minitest/autorun'
require 'minitest/pride'
require 'mocha/minitest'
require './lib/sales_analyst'
require 'pry'
class SalesAnalystTest < Minitest::Test
  def test_it_exists
    sales_engine = SalesEngine.from_csv({
                                :items     => "./fixtures/items_sample.csv",
                                :merchants => "./fixtures/merchant_sample.csv"
                                })
    sales_analyst = sales_engine.analyst
    assert_instance_of SalesAnalyst, sales_analyst
  end

  def test_it_can_average_items_per_merchant_sample
    sales_engine = SalesEngine.from_csv({
                                :items     => "./fixtures/sales_analyst_items_sample.csv",
                                :merchants => "./fixtures/sales_analyst_merchants_sample.csv"
                                })

    sales_analyst = sales_engine.analyst
    assert_equal 1.67, sales_analyst.average_items_per_merchant
  end

  def test_average_for_whole_data_set
      sales_engine = SalesEngine.from_csv({
                                :items     => "./data/items.csv",
                                :merchants => "./data/merchants.csv"
                                })

      sales_analyst = sales_engine.analyst
      assert_equal 2.88, sales_analyst.average_items_per_merchant
  end

  def test_for_standard_deviation
      sales_engine = SalesEngine.from_csv({
                                :items     => "./data/items.csv",
                                :merchants => "./data/merchants.csv"
                                })

      sales_analyst = sales_engine.analyst
      assert_equal 3.26, sales_analyst.average_items_per_merchant_standard_deviation
  end

  def test_for_merchants_with_high_item_count
      sales_engine = SalesEngine.from_csv({
                                :items     => "./data/items.csv",
                                :merchants => "./data/merchants.csv"
                                })
      sales_analyst = sales_engine.analyst
      expected = sales_analyst.merchants_with_high_item_count
      assert_equal 52, expected.count
  end
end
