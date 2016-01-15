require_relative './../lib/sales_analyst'
require_relative './spec_helper'
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

end
