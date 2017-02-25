require_relative 'test_helper'
require_relative '../lib/sales_analyst'

class SalesAnalystTest < Minitest::Test

  def setup
    se = SalesEngine.from_csv({:items => "./data/items_fixture.csv", :merchants => "./data/merchants_fixture.csv" })
    @sa = SalesAnalyst.new(se)    
  end

  def test_it_exists
    
    sa = SalesAnalyst.new(@se)
    assert_instance_of SalesAnalyst, sa
  end  

  def test_that_average_items_per_merchant
    skip
    assert_equal 136.7, @sa.average_items_per_merchant
  end

  def test_sampled_average_items_per_merchant_standard_deviation
    assert_equal 3.3, @sa.average_items_per_merchant_standard_deviation
  end

# Delete this? SD should always use all merchants 
  def test_population_average_items_per_merchant_standard_deviation
    # skip
    se = SalesEngine.from_csv({:items => "./data/items.csv", :merchants => "./data/merchants.csv" })
    sa = SalesAnalyst.new(se)
    # binding.pry
    assert_equal 3.26, sa.average_items_per_merchant_standard_deviation
  end


  def test_sa_can_return_merchants_with_high_item_count
    high_count = @sa.merchants_with_high_item_count
    assert_instance_of Array, high_count 
    assert_equal "Uniford", high_count[0].name
  end

  def test_sa_can_return_average_item_price_for_merchant
    assert_instance_of BigDecimal, @sa.average_item_price_for_merchant(12334174) 
    assert_equal 13.5, @sa.average_item_price_for_merchant(12334174) 
  end


  def test_meta_average_returns_average_of_average_price
    se = SalesEngine.from_csv({:items => "./data/items_fixture.csv", :merchants => "./data/merchants_fixture.csv" })
    sa = SalesAnalyst.new(se)
    assert_instance_of BigDecimal, sa.average_average_price_per_merchant
    assert_equal 13.43, sa.average_average_price_per_merchant
  end

  def test_golden_items

    assert_instance_of Array, sa.golden_items
    assert_instance_of Item, sa.golden_items[0]
    assert_equal "Name"    sa.golden_items[0].name
  end


end