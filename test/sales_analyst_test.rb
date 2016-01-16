require_relative './../lib/sales_analyst'
require_relative './spec_helper'
require          'pry'
require          'minitest/autorun'
require          'minitest/pride'


class SalesAnalystTest < Minitest::Test
  attr_reader :se

  def setup
    @se = SalesEngine.new (
     {  items:    [ {id: 10, merchant_id: 1, name:       "Louis Wallet", unit_price:    "600",  :created_at=>"2016-01-11 10:37:09 UTC", :updated_at=>"2016-01-11 10:37:09 UTC"},
                    {id: 11, merchant_id: 1, name:         "Louis Belt", unit_price:    "300",  :created_at=>"2016-01-11 10:37:09 UTC", :updated_at=>"2016-01-11 10:37:09 UTC"},
                    {id: 12, merchant_id: 1, name:     "Louis Backpack", unit_price:   "2800",  :created_at=>"2016-01-11 10:37:09 UTC", :updated_at=>"2016-01-11 10:37:09 UTC"},
                    {id: 13, merchant_id: 1, name: "Louis PALLAS Purse", unit_price:   "2500",  :created_at=>"2016-01-11 10:37:09 UTC", :updated_at=>"2016-01-11 10:37:09 UTC"},
                    {id: 20, merchant_id: 2, name: "Air Yeezys Red Octobers", unit_price: "5500",  :created_at=>"2016-01-11 10:37:09 UTC", :updated_at=>"2016-01-11 10:37:09 UTC"},
                    {id: 21, merchant_id: 2, name: "Jordan Melo M12", unit_price:    "135",  :created_at=>"2016-01-11 10:37:09 UTC", :updated_at=>"2016-01-11 10:37:09 UTC"},
                    {id: 22, merchant_id: 2, name: "AIR JORDAN 6 RETRO", unit_price: "400",  :created_at=>"2016-01-11 10:37:09 UTC", :updated_at=>"2016-01-11 10:37:09 UTC"},
                    {id: 23, merchant_id: 2, name:  "NIKE AIR HUARACHE", unit_price: "120",  :created_at=>"2016-01-11 10:37:09 UTC", :updated_at=>"2016-01-11 10:37:09 UTC"}],

      merchants: [{:id=>"1", :name=>"Louis Vuitton", :created_at=>"2016-01-11 10:37:09 UTC", :updated_at=>"2016-01-11 10:37:09 UTC"},
                  {:id=>"2", :name=>"Nike", :created_at=>"2016-01-11 10:37:09 UTC", :updated_at=>"2016-01-11 10:37:09 UTC"}]})
  end

  def test_that_class_exist
    assert SalesAnalyst
  end

  def test_that_average_items_per_merchant_method_exist
      assert SalesAnalyst.method_defined? :average_items_per_merchant
  end

  def test_that_average_items_per_merchant_standard_deviation_method_exist
      assert SalesAnalyst.method_defined? :average_items_per_merchant_standard_deviation
  end

  def test_that_merchants_with_low_item_count_method_exist
      assert SalesAnalyst.method_defined? :merchants_with_low_item_count
  end

  def test_that_average_item_price_for_merchant_method_exist
      assert SalesAnalyst.method_defined? :average_item_price_for_merchant
  end

  def test_that_average_price_per_merchant_method_exist
      assert SalesAnalyst.method_defined? :average_price_per_merchant
  end

  def test_that_golden_items_method_exist
      assert SalesAnalyst.method_defined? :golden_items
  end

  def test_that_sales_engine_runs
    a = SalesAnalyst.new(se)

    assert_equal SalesAnalyst, a.class
  end

end
