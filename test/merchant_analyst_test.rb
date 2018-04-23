# frozen_string_literal: true

require_relative 'test_helper'
require_relative '../lib/sales_analyst'
require 'pry'

class MerchantAnalystTest < Minitest::Test
  def setup
    item_path           = './test/fixture_data/item_sa.csv'
    merchant_path       = './test/fixture_data/merchant_sa.csv'
    path                = { items: item_path, merchants: merchant_path }
    sales_engine        = SalesEngine.from_csv(path)
    @sales_analyst      = sales_engine.analyst
    @items_per_merchant = @sales_analyst.items_per_merchant
    @average            = @sales_analyst.average_items_per_merchant
  end

  def test_it_exists
    assert_instance_of SalesAnalyst, @sales_analyst
  end

  def test_it_can_find_average_items_per_merchant
    assert_instance_of Array, @sales_analyst.items_per_merchant
    assert_equal [8, 2, 8, 0, 2], @items_per_merchant
    assert_equal 4, @average
  end

  def test_it_can_find_standard_deviation
    actual = @sales_analyst.average_items_per_merchant_standard_deviation
    assert_equal 3.74, actual
  end

  def test_it_can_find_top_selling_merchants
    assert_instance_of Array, @sales_analyst.merchants_with_high_item_count
    actual = @sales_analyst.merchants_with_high_item_count[0]
    assert_instance_of Merchant, actual
  end

  def test_it_can_find_average_price_for_merchant
    actual = @sales_analyst.average_item_price_for_merchant(12334105).to_f
    assert_equal 17.12, actual
  end

  def test_it_can_find_average_average_price_per_merchant
    assert_equal 54.42, @sales_analyst.average_average_price_per_merchant.to_f
  end
end
