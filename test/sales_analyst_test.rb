# frozen_string_literal: true

require './lib/sales_engine'
require './test/test_helper'
require './lib/sales_analyst'
# tests sales analyst
class SalesAnalystTest < Minitest::Test
  def setup
    @sales_engine_full = SalesEngine.new({ items:     './data/items.csv',
                                           merchants: './data/merchants.csv'})
  end

  def test_it_exists
    sa = SalesAnalyst.new(@sales_engine_full)
    assert_instance_of SalesAnalyst, sa
  end

  def test_all_items_per_by_merchant
    sa = SalesAnalyst.new(@sales_engine_full)
    assert_equal 475, sa.all_items_per_merchant.keys.count
    assert_equal 1367, sa.all_items_per_merchant.values.flatten.count
  end

  def test_average_items_per_merchant
    sa = SalesAnalyst.new(@sales_engine_full)
    assert_equal 2.88, sa.average_items_per_merchant
  end
end
