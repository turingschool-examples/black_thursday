require_relative 'test_helper'
require_relative '../lib/sales_analyst'
require_relative '../lib/sales_engine'

class SalesAnalystTest < Minitest::Test
  attr_reader :sales_analyst
  def setup
    @sales_engine = SalesEngine.from_csv({
      :items     => "./data/test_items.csv",
      :merchants => "./data/test_merchants.csv"
      })
      @sales_analyst = SalesAnalyst.new(@sales_engine)
    end

    def test_it_exists
      assert sales_analyst
    end

    def test_it_takes_sales_engine_instance_as_argument
      assert SalesAnalyst.new(@sales_engine)
    end

    def test_average_items_per_merchant_returns_a_float
      assert Float, sales_analyst.average_items_per_merchant.class
    end

    def test_it_can_calculate_average_items_per_merchant
      assert_equal 0.89, sales_analyst.average_items_per_merchant
    end

    def test_it_calls_sales_engine_object
      assert sales_analyst.sales_engine
    end

    def test_average_items_per_merchant_returns_average
      assert_equal 0.89, sales_analyst.average_items_per_merchant
    end

    def test_distance_from_mean_squared_finds_distance_from_mean_squared
      assert_equal 9.672099999999999, sales_analyst.distance_from_mean_squared(4)
    end

    def test_std_dev_numerator_returns_sum_of_squared_distances_from_mean
      assert_equal 534.5450999999997, sales_analyst.std_dev_numerator
    end

    def test_std_dev_denominator_returns_item_count_minus_one
      assert_equal 130.0, sales_analyst.std_dev_denominator
    end

    def test_avg_items_per_merch_std_dev_returns_std_dev
      assert_equal 2.03, sales_analyst.average_items_per_merchant_standard_deviation
    end

    def test_average_item_price_per_merchant_returns_a_Big_Decimal
      assert BigDecimal, sales_analyst.average_item_price_for_merchant(12334185).class
    end

    def test_it_calculates_the_average_item_price_per_merchant
      expected = 11.166666666666666
      result = sales_analyst.average_item_price_for_merchant(12334185)
      assert_equal expected, result.to_f
    end

    def test_it_finds_merchants_with_items_greater_than_one_std_dev
      high_rollers = sales_analyst.merchants_with_high_item_count
      assert high_rollers.all?{|merchant| merchant.class == Merchant}
      assert high_rollers.all?{|merchant| merchant.items.count > 2.92}
    end

  end
