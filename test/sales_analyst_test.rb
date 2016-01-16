require_relative './../lib/sales_analyst'
require_relative './spec_helper'
require          'pry'
require          'minitest/autorun'
require          'minitest/pride'


class SalesAnalystTest < Minitest::Test
  attr_reader :se

  def setup
    @se = SalesEngine.new (
     {  items:    [{id: 1, merchant_id: 1, name: "Louis Wallet", unit_price: "2999",  :created_at=>"2016-01-11 10:37:09 UTC", :updated_at=>"2016-01-11 10:37:09 UTC"},
                    {id: 2, merchant_id: 2, name: "Yeezys", unit_price: "1000",  :created_at=>"2016-01-11 10:37:09 UTC", :updated_at=>"2016-01-11 10:37:09 UTC"},
                    {id: 3, merchant_id: 3, name: "Los Angeles Cap", unit_price: "40",  :created_at=>"2016-01-11 10:37:09 UTC", :updated_at=>"2016-01-11 10:37:09 UTC"}],

      merchants: [{:id=>"1", :name=>"Louis Vuitton", :created_at=>"2016-01-11 10:37:09 UTC", :updated_at=>"2016-01-11 10:37:09 UTC"},
                  {:id=>"2", :name=>"Nike", :created_at=>"2016-01-11 10:37:09 UTC", :updated_at=>"2016-01-11 10:37:09 UTC"},
                  {:id=>"2", :name=>"New Era", :created_at=>"2016-01-11 10:37:09 UTC", :updated_at=>"2016-01-11 10:37:09 UTC"}]})
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
