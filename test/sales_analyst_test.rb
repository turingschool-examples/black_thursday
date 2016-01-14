require_relative './../lib/sales_analyst'
require_relative './test_helper'
require          'pry'
require          'minitest/autorun'
require          'minitest/pride'


class SalesAnalystTest < Minitest::Test

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

  def test_that_will_start_the_relationship_function
    se = SalesEngine.new(
    {
      items:     [ {id: "1", merchant_id:  "1", name: "Vogue Paris 2307", unit_price: "2999"},
                   {id: "2", merchant_id: "1", name: "Givenchy 2307", unit_price: "2999"},
                   {id: "3", merchant_id: "2", name: "Givenchy 2307", unit_price: "2999"}],

      merchants: [{:id=>"1", :name=>"Shopin1901", :created_at=>"2016-01-11 10:37:09 UTC", :updated_at=>"2016-01-11 10:37:09 UTC"}]
      })q
      binding.pry
    merchant = se.merchants.find_by_id("1")

    assert_equal 2, merchant.items.count
  end

  def test_that_will_start_the_function
    se = SalesEngine.new(
    {
      items:     [ {id: "1", merchant_id:  "1", name: "Vogue Paris 2307", unit_price: "2999"},
                   {id: "2", merchant_id: "1", name: "Givenchy 2307", unit_price: "2999"},
                   {id: "3", merchant_id: "2", name: "Givenchy 2307", unit_price: "2999"}],

      merchants: [{:id=>"1", :name=>"Shopin1901", :created_at=>"2016-01-11 10:37:09 UTC", :updated_at=>"2016-01-11 10:37:09 UTC"}]
      })
      item = se.items.find_by_id("1")
      # binding.pry
      #BY ITEM ID COMPARED TO MERCHANT ID
      assert_equal "1", item.merchant
      # => <merchant>
    end
end
