require './test/test_helper'
require_relative '../lib/sales_analyst'
require_relative '../lib/sales_engine'

class SalesAnalystTest < Minitest::Test

  def setup
    @se = SalesEngine.new("")
    @ir = @se.item_repo
    @mr = @se.merchant_repo
    @sa = SalesAnalyst.new(@se)
    item_1 = {
      :id => 1,
      :merchant_id => 1,
      :name => "A tiny piece of cheese",
      :unit_price => 10
    }
    item_2 = {
      :id => 2,
      :merchant_id => 1,
      :name => "A baseball of mozzarella",
      :unit_price => 20
    }
    item_3 = {
      :id => 3,
      :merchant_id => 1,
      :name => "A golfball of gorgonzola",
      :unit_price => 30
    }
    item_4 = {
      :id => 4,
      :merchant_id => 2,
      :name => "A dead bird in a bag",
      :description => "I don't know what I expected",
      :unit_price => 5000
    }
    item_5 = {
      :id => 5,
      :merchant_id => 2,
      :name => "Frozen banana",
      :unit_price => 5
    }
    merchant_1 = {
      :name => "Ghengis' Cheese Shop",
      :id => 1
    }
    merchant_2 = {
      :name => "Bluth Family Store",
      :id => 2
    }
    item_details = [item_1, item_2, item_3, item_4, item_5]
    merchant_details = [merchant_1, merchant_2]
    item_details.each do |item|
      @ir.add_item(item)
    end
    merchant_details.each do |merchant|
      @mr.add_merchant(merchant)
    end
  end

  def test_analyst_can_get_merchant_and_their_items
    expected_items = @mr.all.first.items
    assert_equal expected_items, @sa.sales_engine.find_all_items_by_merchant_id(1)
  end

  def test_average_price_for_merchant
    assert_equal 20, @sa.average_price_for_merchant(1)
    assert_equal 2502.5, @sa.average_price_for_merchant(2)
  end

  def test_average_price_per_merchant
    assert_equal 1261.25, @sa.average_price_per_merchant
  end

  def test_get_individual_standard_deviation_price
    assert_equal 10, @sa.price_standard_deviation_for_merchant(1)
    assert_equal 3532, @sa.price_standard_deviation_for_merchant(2)
  end

  def test_get_all_item_price_standard_deviation
    assert_equal 2228.82, @sa.price_standard_deviation
  end

  def test_find_golden_items
    expected_item = @ir.find_by_name("A dead bird in a bag")
    assert_equal [expected_item], @sa.golden_items(1)
  end
end
