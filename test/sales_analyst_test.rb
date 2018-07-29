require 'minitest/autorun'
require 'minitest/pride'
require 'pry'
require_relative '../lib/sales_engine'
require_relative '../lib/sales_analyst'

class SalesAnalystTest < Minitest::Test 

  def setup 
    @sales_engine = SalesEngine.new({
    :items     => "./data/items.csv",
    :merchants => "./data/merchants.csv",
     })
    @sales_analyst = @sales_engine.analyst
  end 
  
  def test_it_exists
    assert_instance_of SalesAnalyst, @sales_analyst
  end
  
  def test_it_has_attributes
    assert_equal SalesEngine, @sales_analyst.sales_engine.class
    assert_equal ItemRepository, @sales_analyst.item_repository.class
    assert_equal 1367, @sales_analyst.item_repository.all.count
    assert_equal MerchantRepository, @sales_analyst.merchant_repository.class
    assert_equal 475, @sales_analyst.merchant_repository.all.count
    assert_nil @sales_analyst.merchant_id_item_counts
    assert_nil @sales_analyst.item_count_std_dev 
  end 
  
  def test_merchant_id_item_counts_attribute_can_be_populated
    @sales_analyst.merchant_id_item_counter 
    assert_equal 475, @sales_analyst.merchant_id_item_counts.count 
  end 
  
  def test_average_items_per_merchant_standard_deviation_can_be_populated 
    @sales_analyst.merchant_id_item_counter
    @sales_analyst.average_items_per_merchant_standard_deviation
    assert_equal Float, @sales_analyst.item_count_std_dev.class
  end 
  
  def test_average_items_per_merchant_standard_deviation
    assert_equal 3.26, @sales_engine.analyst.average_items_per_merchant_standard_deviation 
    assert_equal Float, @sales_engine.analyst.average_items_per_merchant_standard_deviation.class 
  end 

  def test_average_items_per_merchant 
    assert_equal 2.88, @sales_engine.analyst.average_items_per_merchant 
    assert_equal Float, @sales_engine.analyst.average_items_per_merchant.class 
  end
  
  def test_it_sums_differences_squared
    @sales_analyst.sum_of_differences_squared
    assert_equal 5034.92, @sales_analyst.sum_of_differences_squared.round(2)
  end 
  
  def test_it_builds_hash_of_merchant_item_counts
    assert_equal Hash, @sales_analyst.merchant_id_item_counter.class 
    assert_equal 475, @sales_analyst.merchant_id_item_counter.count 
    assert_equal [12334105, 3], @sales_analyst.merchant_id_item_counter.first
  end
  
  #sales_analyst.merchants_with_high_item_count # => [merchant, merchant, merchant]
  
  def test_it_finds_merchants_with_high_item_count
    @sales_analyst.merchant_id_item_counter
    @sales_analyst.average_items_per_merchant_standard_deviation
    assert_equal Array, @sales_analyst.merchants_with_high_item_count.class 
    assert_equal Merchant, @sales_analyst.merchants_with_high_item_count[0].class
    assert_equal 114, @sales_analyst.merchants_with_high_item_count.count 
  end 
  
  def test_it_finds_ids_with_high_item_count
    @sales_analyst.merchant_id_item_counter
    @sales_analyst.average_items_per_merchant_standard_deviation
    
    assert_equal Array, @sales_analyst.ids_with_high_item_count.class
    assert_equal Array, @sales_analyst.ids_with_high_item_count[0].class
    assert_equal 114, @sales_analyst.ids_with_high_item_count.count
  end 
  
end 