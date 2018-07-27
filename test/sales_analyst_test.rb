require_relative 'test_helper'
require_relative '../lib/merchant_repo'
require_relative '../lib/item_repo'
require_relative '../lib/sales_analyst'

class SalesAnalystTest < Minitest::Test

  def setup
    merchant_array = [{:id=>"12334105", :name=>"Shopin1901", :created_at=>"2010-12-10", :updated_at=>"2011-12-04"},
      {:id=>"12334112", :name=>"Candisart", :created_at=>"2009-05-30", :updated_at=>"2010-08-29"},
      {:id=>"12334113", :name=>"Sandy", :created_at=>"2010-03-30", :updated_at=>"2013-01-21"},
      {:id=>"12334115", :name=>"sandy", :created_at=>"2008-06-09", :updated_at=>"2015-04-16"},
      {:id=>"12334123", :name=>"Keckenbauer", :created_at=>"2010-07-15", :updated_at=>"2012-07-25"}]
    @mer_repo = MerchantRepo.new(merchant_array)

    item_array = [{id: 263395237, name: "Cow1" , description: "animal 1", unit_price: "1400", created_at: "2016-01-11 11:51:37 UTC", updated_at: "2016-01-11 11:51:37 UTC", merchant_id: "12334195"},
      {id: 263395238, name: "Cow1", description: "animal 1", unit_price: "1400", created_at: "2016-01-11 11:51:37 UTC", updated_at: "2016-01-11 11:51:37 UTC", merchant_id: "12334195"},
      {id: 263395239, name: "cow1", description: "animal 1", unit_price: "1400", created_at: "2016-01-11 11:51:37 UTC", updated_at: "2016-01-11 11:51:37 UTC", merchant_id: "12334195"},
      {id: 263395210, name: "Moose1", description: "animal 2", unit_price: "1700", created_at: "2016-01-11 11:51:37 UTC", updated_at: "2016-01-11 11:51:37 UTC", merchant_id: "12334101"},
      {id: 263395211, name: "Moose2", description: "animal 3", unit_price: "1800", created_at: "2016-01-11 11:51:37 UTC", updated_at: "2016-01-11 11:51:37 UTC", merchant_id: "12334102"},
      {id: 263395212, name: "Pig", description: "animal 4", unit_price: "1400", created_at: "2016-01-11 11:51:37 UTC", updated_at: "2016-01-11 11:51:37 UTC", merchant_id: "12334103"}]
    @item_repo = ItemRepo.new(item_array)

    @sales_analyst = SalesAnalyst.new(@mer_repo, @item_repo)
  end

  def test_it_exists
    assert_instance_of SalesAnalyst, @sales_analyst
  end

  def test_it_has_repositories
    assert_instance_of MerchantRepo, @sales_analyst.merchants
    assert_instance_of ItemRepo, @sales_analyst.items
  end

  # How many products do merchants sell?
  # Do most of our merchants offer just a few items or do they represent a warehouse?
  def test_it_calculates_average_items_per_merchant

    assert_equal 1.2, @sales_analyst.average_items_per_merchant
  end
  # sales_analyst.average_items_per_merchant # => 2.88

  # And what’s the standard deviation?
  #
  # sales_analyst.average_items_per_merchant_standard_deviation # => 3.26
  # Note on Standard Deviations
  # There are two ways for calculating standard deviations – for a population and for a sample.
  #
  # For this project, use the sample standard deviation.
  #
  # As an example, given the set 3,4,5. We would calculate the deviation using the following steps:
  #
  # Take the difference between each number and the mean and square it
  # Sum these square differences together
  # Divide the sum by the number of elements minus 1
  # Take the square root of this result
  # Or, in pseudocode:
  #
  # set = [3,4,5]
  #
  # std_dev = sqrt( ( (3-4)^2+(4-4)^2+(5-4)^2 ) / 2 )
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

end
