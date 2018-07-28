require_relative 'test_helper'
require_relative '../lib/merchant_repo'
require_relative '../lib/item_repo'
require_relative '../lib/sales_analyst'
require 'bigdecimal'

class SalesAnalystTest < Minitest::Test

  def setup
    merchant_array = [{:id=>"12334105", :name=>"Shopin1901", :created_at=>"2010-12-10", :updated_at=>"2011-12-04"},
      {:id=>"12334112", :name=>"Candisart", :created_at=>"2009-05-30", :updated_at=>"2010-08-29"},
      {:id=>"12334113", :name=>"Sandy", :created_at=>"2010-03-30", :updated_at=>"2013-01-21"}]
    @mer_repo = MerchantRepo.new(merchant_array)

    item_array = [{id: 263395237, name: "Cow1" , description: "animal 1", unit_price: "1400", created_at: "2016-01-11 11:51:37 UTC", updated_at: "2016-01-11 11:51:37 UTC", merchant_id: "12334105"},
      {id: 263395238, name: "Cow1", description: "animal 1", unit_price: "1400", created_at: "2016-01-11 11:51:37 UTC", updated_at: "2016-01-11 11:51:37 UTC", merchant_id: "12334105"},
      {id: 263395239, name: "cow1", description: "animal 1", unit_price: "1400", created_at: "2016-01-11 11:51:37 UTC", updated_at: "2016-01-11 11:51:37 UTC", merchant_id: "12334105"},
      {id: 263395210, name: "Moose1", description: "animal 2", unit_price: "1700", created_at: "2016-01-11 11:51:37 UTC", updated_at: "2016-01-11 11:51:37 UTC", merchant_id: "12334112"},
      {id: 263495211, name: "Moose2", description: "animal 3", unit_price: "1800", created_at: "2016-01-11 11:51:37 UTC", updated_at: "2016-01-11 11:51:37 UTC", merchant_id: "12334112"},
      {id: 263397515, name: "Pig", description: "animal 4", unit_price: "1400", created_at: "2016-01-11 11:51:37 UTC", updated_at: "2016-01-11 11:51:37 UTC", merchant_id: "12334112"},
      {id: 263895112, name: "Pig", description: "animal 4", unit_price: "1400", created_at: "2016-01-11 11:51:37 UTC", updated_at: "2016-01-11 11:51:37 UTC", merchant_id: "12334112"},
      {id: 263395240, name: "cow1", description: "animal 1", unit_price: "1400", created_at: "2016-01-11 11:51:37 UTC", updated_at: "2016-01-11 11:51:37 UTC", merchant_id: "12334113"},
      {id: 263305218, name: "Moose1", description: "animal 2", unit_price: "1700", created_at: "2016-01-11 11:51:37 UTC", updated_at: "2016-01-11 11:51:37 UTC", merchant_id: "12334113"},
      {id: 263395217, name: "Moose2", description: "animal 3", unit_price: "1800", created_at: "2016-01-11 11:51:37 UTC", updated_at: "2016-01-11 11:51:37 UTC", merchant_id: "12334113"},
      {id: 263395216, name: "Pig", description: "animal 4", unit_price: "1400", created_at: "2016-01-11 11:51:37 UTC", updated_at: "2016-01-11 11:51:37 UTC", merchant_id: "12334113"},
      {id: 263395314, name: "Pig", description: "animal 4", unit_price: "1400", created_at: "2016-01-11 11:51:37 UTC", updated_at: "2016-01-11 11:51:37 UTC", merchant_id: "12334113"},
      {id: 263365314, name: "Pig", description: "animal 4", unit_price: "1400", created_at: "2016-01-11 11:51:37 UTC", updated_at: "2016-01-11 11:51:37 UTC", merchant_id: "12334113"},
      {id: 263375314, name: "Pig", description: "animal 4", unit_price: "1400", created_at: "2016-01-11 11:51:37 UTC", updated_at: "2016-01-11 11:51:37 UTC", merchant_id: "12334113"},
      {id: 263345314, name: "Pig", description: "animal 4", unit_price: "1400", created_at: "2016-01-11 11:51:37 UTC", updated_at: "2016-01-11 11:51:37 UTC", merchant_id: "12334113"}]
    @item_repo = ItemRepo.new(item_array)

    @analyst = SalesAnalyst.new(@mer_repo, @item_repo)
  end

  def test_it_exists
    assert_instance_of SalesAnalyst, @analyst
  end

  def test_it_has_repositories
    assert_instance_of MerchantRepo, @analyst.merchants
    assert_instance_of ItemRepo, @analyst.items
  end

  def test_it_calculates_average_items_per_merchant
    assert_equal 5.0, @analyst.average_items_per_merchant
  end

  def test_it_calculates_standard_deviation
    @analyst.return_array_of_unique_merchants
    assert_equal 2.65, @analyst.average_items_per_merchant_standard_deviation
  end

  def test_it_returns_merchants_ids_for_high_item_count
    assert_equal [[@mer_repo.merchants[2], 8]], @analyst.merchants_ids_for_high_item_count
  end
    

  def test_it_returns_merchants_with_high_item_count
    assert_equal [@mer_repo.merchants[2]], @analyst.merchants_with_high_item_count
  end
  
  def test_it_calculates_average_item_price_for_merchant 
    assert_equal BigDecimal(14.88,4), @analyst.average_item_price_for_merchant(12334113)
  
  end
  def test_it_returns_all_average_prices 
    assert_equal [BigDecimal(14.00,4), BigDecimal(15.75,4), BigDecimal(14.88,4)], @analyst.all_average_prices
  end
  
  def test_it_calculates_average_average_price_per_merchant
    assert_equal BigDecimal(14.88,4), @analyst.average_average_price_per_merchant
  end
  
end

  # def test_it_returns_merchants_with_high_item_count
  #   assert
  # end

  # def test_returns_hash_of_merchants_with_items
  #   @analyst.return_hash_of_merchants_with_items
  # end

  # Which merchants sell the most items?
  # Maybe we could set a good example for our lower sellers by displaying the merchants who have the most items for sale. Which merchants are more than one standard deviation above the average number of products offered?
  #
  # sales_analyst.merchants_with_high_item_count # => [merchant, merchant, merchant]
  # What are prices like on our platform?
  # Are these merchants selling commodity or luxury goods? Let’s find the average price of a merchant’s items (by supplying the merchant ID):
  #
  # sales_analyst.average_item_price_for_merchant(12334159) # => BigDecimal
  # Then we can sum all of the averages and find the average price across all merchants (this implies that each merchant’s average has equal weight in the calculation):
  #
  # sales_analyst.average_average_price_per_merchant # => BigDecimal
  # Which are our Golden Items?
  # Given that our platform is going to charge merchants based on their sales, expensive items are extra exciting to us. Which are our “Golden Items”, those two standard-deviations above the average item price? Return the item objects of these “Golden Items”.
  #
  # sales_analyst.golden_items # => [<item>, <item>, <item>, <item>]
