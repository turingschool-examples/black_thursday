require_relative 'test_helper'
require_relative '../lib/sales_analyst'

class SalesAnalystTest < Minitest::Test

  def setup
    se = SalesEngine.from_csv({:items => "./data/items.csv", :merchants => "./data/merchants_fixture.csv" })
    @sa = SalesAnalyst.new(se)    
  end

  #note: not using fixtures. Consider update
  def test_it_exists
    
    sa = SalesAnalyst.new(@se)

    assert_instance_of SalesAnalyst, sa
  end  

  def test_that_average_items_per_merchant
    assert_equal 136.7, @sa.average_items_per_merchant
  end

  def test_that_average_items_per_merchant_standard_deviation
    
    assert_equal 1.18, @sa.average_items_per_merchant_standard_deviation
  end


  def test_sa_can_return_merchants_with_high_item_count
    skip
    assert_equal "hello", @sa.merchants_with_high_item_count # => [merchant, merchant, merchant]
  end

  def test_that_average_item_price_for_merchant_returns_average__price
    skip
    assert_instance_of BigDecimal, @sa.average_item_price_for_merchant(12334159) 
  end
  

end