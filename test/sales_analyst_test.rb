require_relative 'test_helper.rb'
require_relative '../lib/sales_analyst'
require_relative '../lib/sales_engine'

class SalesAnalystTest < Minitest::Test
  attr_reader :se, :sa
  
  def setup 
    @se = SalesEngine.from_csv({
        :merchants     => "./test/fixtures/merchants_sales_analyst.csv",
        :items     => "./test/fixtures/items_robust_sa.csv"
        })
        
    @sa = SalesAnalyst.new(se)
  end
  
  def test_it_exists
    sa = SalesAnalyst.new

    assert_instance_of SalesAnalyst, sa
  end
  
  def test_it_calculates_average_items_per_merchant
    assert_equal 2.33, sa.average_items_per_merchant
  end
  
  def test_it_calculates_standard_deviation
    assert_equal 1.53, sa.average_items_per_merchant_standard_deviation
  end
  
  def test_knows_merchants_with_highest_item_count
    assert_equal Array, sa.merchants_with_high_item_count.class
    assert_equal 12334122, sa.merchants_with_high_item_count.first.id
  end
  
  def test_it_knows_average_item_price_for_merchant
    assert_instance_of BigDecimal, sa.average_item_price_for_merchant(12334185)
    assert_equal 97.90, sa.average_item_price_for_merchant(12334185).to_f.round(2)
  end
  
  def test_it_knows_average_of_average_price_per_merchant
    assert_instance_of BigDecimal, sa.average_average_price_per_merchant
    assert_equal 96.41, sa.average_average_price_per_merchant.to_f.round(2)
  end
  
  def test_it_calculates_average_item_price
    assert_equal 96.20, sa.average_item_price
  end
  
  # need a test for item price av that would give 3 decimal places
  
  def test_it_calculates_item_price_standard_deviation
    assert_equal 2.17, sa.item_price_standard_deviation
  end
  
  def test_it_knows_golden_items
    assert_instance_of Array, sa.golden_items
    assert_equal "Dinosaurs", sa.golden_items.first.name
  end
  
end