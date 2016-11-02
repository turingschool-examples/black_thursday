require_relative 'test_helper'
require_relative '../lib/sales_analyst'
require_relative '../lib/sales_engine'

class SalesAnalystTest < Minitest::Test
  attr_reader :sales_analyst
  def setup
    sales_engine = SalesEngine.from_csv({
      :items     => "./data/test_items1.csv",
      :merchants => "./data/test_merchants1.csv"
    })
    @sales_analyst = SalesAnalyst.new(sales_engine)
  end

  def test_the_class_exists
    assert sales_analyst
  end

  def test_average_items_per_merchant_returns_a_float
    assert Float, sales_analyst.average_items_per_merchant.class
  end

  def test_it_can_calculate_average_items_per_merchant
   assert_equal 0.89, sales_analyst.average_items_per_merchant
  end

  # def test_we_can_calculate_standard_deviation
  #   assert_equal "" , sales_analyst.average_items_per_merchant_standard_deviation
  # end
  
  def test_average_item_price_per_merchant_returns_a_Big_Decimal
    assert BigDecimal, sales_analyst.average_item_price_per_merchant(12334185).class
  end

  def test_it_calculates_the_average_item_price_per_merchant
    result = BigDecimal.new('0.335E2',18)
    assert_equal result, sales_analyst.average_item_price_per_merchant(12334185)
  end

end
