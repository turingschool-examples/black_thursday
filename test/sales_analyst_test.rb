require './test/test_helper.rb'
require 'csv'
require 'pry'

class SalesAnalystTest < Minitest::Test
  def setup
    @sales_engine = SalesEngine.from_csv({:items => './data/items.csv', :merchants => './data/merchants.csv'})
    @sales_analyst = SalesAnalyst.new(@sales_engine)
  end

  def test_it_exists
    assert @sales_analyst
  end

  def test_it_finds_average_number_items
    assert_equal 2.88, @sales_analyst.average_items_per_merchant
  end

  def test_it_finds_standard_deviation
    assert_equal 3.26, @sales_analyst.average_items_per_merchant_standard_deviation
  end
  
  def test_merchants_selling_more_items
    assert_equal 52, @sales_analyst.merchants_with_high_item_count.length
  end
  
  def test_average_price_merchant
    assert_instance_of BigDecimal , @sales_analyst.average_item_price_for_merchant(12334159)
  end

  def test_average_of_averages
    assert_instance_of BigDecimal , @sales_analyst.average_average_price_per_merchant
  end

  def test_price_standard_dev
    assert_equal 3, @sales_analyst.price_std_dev
  end
end