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
    assert_instance_of SalesAnalyst, se
  end

  def test_average_items_per_merchant
    sa = SalesAnalyst.new(@sales_engine_full)
    assert_equal 2.88, sa.average_items_per_merchant
  end
end
