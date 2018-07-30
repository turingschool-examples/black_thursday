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
    :invoices  => "./data/invoices.csv"
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
    assert_equal InvoiceRepository, @sales_analyst.invoice_repository.class
    assert_equal 4985, @sales_analyst.invoice_repository.all.count
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
    assert_equal 2.88, @sales_analyst.average_items_per_merchant 
    assert_equal Float, @sales_analyst.average_items_per_merchant.class 
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
  
  def test_it_finds_merchants_with_high_item_count
    @sales_analyst.merchant_id_item_counter
    @sales_analyst.average_items_per_merchant_standard_deviation
    assert_equal Array, @sales_analyst.merchants_with_high_item_count.class 
    assert_equal Merchant, @sales_analyst.merchants_with_high_item_count[0].class
    assert_equal 52, @sales_analyst.merchants_with_high_item_count.count 
  end 
  
  def test_it_finds_ids_with_high_item_count
    assert_equal Array, @sales_analyst.ids_with_high_item_count.class
    assert_equal Array, @sales_analyst.ids_with_high_item_count[0].class
    assert_equal 52, @sales_analyst.ids_with_high_item_count.count
  end
  
  def test_average_average_price_per_merchant
    assert_equal BigDecimal, @sales_analyst.average_average_price_per_merchant.class
    assert_equal 350.29, @sales_analyst.average_average_price_per_merchant
  end 
  
  def test_it_creates_array_of_averages_per_merchant 
    assert_equal Array, @sales_analyst.create_array_of_averages_per_merchant.class
    assert_equal BigDecimal, @sales_analyst.create_array_of_averages_per_merchant[0].class
    assert_equal @sales_analyst.merchant_repository.all.count, @sales_analyst.create_array_of_averages_per_merchant.count
  end

  def test_average_item_price_for_merchant 
    assert_equal 16.66, @sales_analyst.average_item_price_for_merchant(12334105)
    assert_equal BigDecimal, @sales_analyst.average_item_price_for_merchant(12334105).class
  end
  
  def test_it_finds_items_by_merchant_id
    assert_equal Array, @sales_analyst.find_items_by_merchant_id(12334159).class 
    assert_equal 10, @sales_analyst.find_items_by_merchant_id(12334159).count 
    assert_equal Item, @sales_analyst.find_items_by_merchant_id(12334159)[0].class
  end 
  
  def test_it_creates_price_array 
    assert_equal Array, @sales_analyst.create_price_array(12334159).class
    assert_equal 10, @sales_analyst.create_price_array(12334159).count
    assert_equal BigDecimal, @sales_analyst.create_price_array(12334159)[0].class
  end 
  
  def test_it_sums_prices_in_price_array
    assert_equal 15, @sales_analyst.sum_prices_in_price_array([1, 2, 3, 4, 5])
  end
  
  def test_it_returns_golden_items 
    assert_equal 5, @sales_analyst.golden_items.length
    assert_equal Item, @sales_analyst.golden_items[0].class
  end
  
  def test_price_standard_deviation
    assert_equal 2899.93, @sales_analyst.price_standard_deviation
  end 
  
  def test_sum_of_price_differences_squared 
    assert_equal BigDecimal, @sales_analyst.sum_of_price_differences_squared.class 
  end 
  
  def test_average_item_price 
    assert_equal BigDecimal, @sales_analyst.average_item_price.class
  end
  
  def test_average_invoices_per_merchant 
    assert_equal 10.49, @sales_analyst.average_invoices_per_merchant 
    assert_equal Float, @sales_analyst.average_invoices_per_merchant.class 
  end 
end 