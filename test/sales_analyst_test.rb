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
    # binding.pry 
  end 
  
  def test_it_exists
    assert_instance_of SalesAnalyst, @sales_analyst
  end
  
  def test_it_has_attributes
    assert_equal SalesEngine, @sales_analyst.sales_engine.class
    assert_equal ItemRepository, @sales_analyst.item_repository.class
    assert_equal 1367, @sales_analyst.item_repository.items.count
    assert_equal MerchantRepository, @sales_analyst.merchant_repository.class
    assert_equal 475, @sales_analyst.merchant_repository.all.count
  end  
    
  
  def test_average_items_per_merchant 
    assert_equal 2.88, @sales_engine.analyst.average_items_per_merchant 
    assert_equal Float, @sales_engine.analyst.average_items_per_merchant.class 
  end
  
  # def test_item_count_by_merchant 
  #   @sales_analyst.item_count_by_merchant
  #   # binding.pry
  # end 
  
  def test_it_builds_hash_of_merchant_item_counts
    @sales_analyst.build_hash_of_merchant_item_counts
  end 
  
  # def test_average_items_per_merchant_standard_deviation
  #   assert_equal 3.26, @sales_engine.analyst.average_items_per_merchant_standard_deviation 
  #   assert_equal Float, @sales_engine.analyst.average_items_per_merchant_standard_deviation.class 
  # end 

  # it "#average_items_per_merchant_standard_deviation returns the standard deviation" do
  #   expected = sales_analyst.average_items_per_merchant_standard_deviation
  # 
  #   expect(expected).to eq 3.26
  #   expect(expected.class).to eq Float
  # end
end 