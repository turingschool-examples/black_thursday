require_relative './test_helper'
require_relative '../lib/sales_analyst'

class SalesAnalystTest < Minitest::Test
  def test_average_items_per_merchant
    se = SalesEngine.new("empty") 
    sa = SalesAnalyst.new(se)
    ir = se.item_repo
    mr = se.merchant_repo
    item_1_details = {
      :id => 20,
      :name => "A thing that you want",
      :merchant_id => 21
    }
    item_2_details = {
      :id =>22,
      :name => "A thing you sorta want",
      :merchant_id => 21
    }
  
    items = [item_1_details, item_2_details]
    merchant_1_details = {
      :name => "The awesome store",
      :id   => 21
    }
    merchant_2_details = {
      :name => "Trump Store of Fail",
      :id   => 666
    }
    merchants = [merchant_1_details, merchant_2_details]

    items.each do |item|
      ir.add_item(item)
    end
    merchants.each do |merchant|
      mr.add_merchant(merchant)
    end
    
    assert_equal 1, sa.average_items_per_merchant
  end
  
  def test_average_items_per_merchant_standard_deviation
    se = SalesEngine.new("empty") 
    sa = SalesAnalyst.new(se)
    ir = se.item_repo
    mr = se.merchant_repo
    item_1_details = {
      :id => 20,
      :name => "A thing that you want",
      :merchant_id => 21
    }
    item_2_details = {
      :id =>22,
      :name => "A thing you sorta want",
      :merchant_id => 21
    }
  
    items = [item_1_details, item_2_details]
    merchant_1_details = {
      :name => "The awesome store",
      :id   => 21
    }
    merchant_2_details = {
      :name => "Trump Store of Fail",
      :id   => 666
    }
    merchants = [merchant_1_details, merchant_2_details]

    items.each do |item|
      ir.add_item(item)
    end
    merchants.each do |merchant|
      mr.add_merchant(merchant)
    end
    
    assert_equal 1.4142135623730951, sa.average_items_per_merchant_standard_deviation
  end
  
  def test_merchants_with_high_item_count
    se = SalesEngine.new("empty")
    sa = SalesAnalyst.new(se)
    ir = se.item_repo
    mr = se.merchant_repo
    item_1_details = {
      :id => 20,
      :name => "A thing that you want",
      :merchant_id => 21
    }
    item_2_details = {
      :id =>22,
      :name => "A thing you sorta want",
      :merchant_id => 21
    }
    item_3_details = {
      :id => 24,
      :name => "A thing that you kind of want",
      :merchant_id => 21
    }
    item_4_details = {
      :id =>26,
      :name => "A thing you really want",
      :merchant_id => 21
    }
    items = [item_1_details, item_2_details, item_3_details, item_4_details]
    merchant_1_details = {
      :name => "The awesome store",
      :id   => 21
    }
    merchant_2_details = {
      :name => "Trump Store of Fail",
      :id   => 666
    }
    merchants = [merchant_1_details, merchant_2_details]

    items.each do |item|
      ir.add_item(item)
    end
    merchants.each do |merchant|
      mr.add_merchant(merchant)
    end
    
    assert_equal [], sa.merchants_with_high_item_count
  end
end