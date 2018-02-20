require_relative 'test_helper.rb'
require_relative '../lib/sales_analyst.rb'
require_relative '../lib/sales_engine.rb'

class SalesAnalystTest < Minitest::Test

  def setup
    @sales_engine = SalesEngine.from_csv({
      items: './data/items.csv',
      merchants: './data/merchants.csv'
      })

    @sales_analyst = SalesAnalyst.new(@sales_engine)
  end

  def test_analyst_initializes
    assert_instance_of SalesAnalyst, @sales_analyst
  end

  def test_merchant_collector_helper_method_works
    result = @sales_analyst.merchant_collector

    assert_instance_of Array, result
    assert_instance_of Merchant, result[0]
  end

  def test_can_return_average_items_per_merchant
    result = @sales_analyst.average_items_per_merchant

    assert_equal 2.88, result
  end

  def test_can_return_standard_deviation
    result = @sales_analyst.average_items_per_merchant_standard_deviation

    assert_equal 3.26, result
  end

  def test_can_find_merchants_with_high_item_count
    result = @sales_analyst.merchants_with_high_item_count

    assert_instance_of Array, result
    assert_instance_of Merchant, result[0]
  end

  def test_can_find_average_item_price_of_merchant
    result = @sales_analyst.average_item_price_for_merchant(12334159)

    assert_instance_of BigDecimal, result
  end
end
