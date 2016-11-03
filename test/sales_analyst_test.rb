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

    def test_avg_items_per_merch_std_dev_returns_std_dev
      assert_equal 2.03, sales_analyst.average_items_per_merchant_standard_deviation
    end

    def test_average_item_price_per_merchant_returns_a_Big_Decimal
      assert BigDecimal, sales_analyst.average_item_price_for_merchant(12334185).class
    end

    def test_it_calculates_the_average_item_price_per_merchant
      expected = 11.17
      result = sales_analyst.average_item_price_for_merchant(12334185)
      assert_equal expected, result.to_f
    end

    def test_it_finds_merchants_with_items_greater_than_one_std_dev
      high_rollers = sales_analyst.merchants_with_high_item_count
      assert high_rollers.all?{|merchant| merchant.class == Merchant}
      assert high_rollers.all?{|merchant| merchant.items.count > 2.92}
      assert_equal 10, high_rollers.count
    end

    def test_average_average_price_per_merchant_returns_a_Big_Decimal
      assert BigDecimal, sales_analyst.average_average_price_per_merchant
    end

    def test_it_finds_the_average_of_average_price_per_merchant
      assert_equal 814.8, sales_analyst.average_average_price_per_merchant
    end

    def test_golden_items_returns_items_with_price_greater_than_2_std_devs_above_avg_price
      gold_items = sales_analyst.golden_items
      assert gold_items.all?{|item| item.unit_price > 18221.5}
      assert gold_items.all?{|item| item.class == Item}
      assert_equal 1, gold_items.count
    end

    def test_items_returns_all_items_array
      assert_equal Array, sales_analyst.items.class
      assert sales_analyst.items.all? { |item| item.class == Item}
      expected = sales_analyst.sales_engine.all_items.count
      assert_equal expected, sales_analyst.items.count
    end

    def test_merchants_returns_all_merchants_array
      assert_equal Array, sales_analyst.merchants.class
      assert sales_analyst.merchants.all? { |merchant| merchant.class == Merchant}
      expected = sales_analyst.sales_engine.all_merchants.count
      assert_equal expected, sales_analyst.merchants.count
    end

  end
