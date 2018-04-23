# frozen_string_literal: true

require_relative 'test_helper'
require_relative '../lib/sales_analyst'
require 'pry'

class ItemAnalystTest < Minitest::Test
  def setup
    item_path      = './test/fixture_data/item_sa.csv'
    merchant_path  = './test/fixture_data/merchant_sa.csv'
    path           = { items: item_path, merchants: merchant_path }
    sales_engine = SalesEngine.from_csv(path)
    @sales_analyst = SalesAnalyst.new(sales_engine)
    @items_per_merchant = @sales_analyst.items_per_merchant
    @average = @sales_analyst.average_items_per_merchant
  end

  def test_it_can_find_golden_items
    assert_instance_of Array, @sales_analyst.golden_items
    assert_instance_of Item, @sales_analyst.golden_items[0]
    sorted_golden_items = @sales_analyst.golden_items
    actual_1 = sorted_golden_items.map(&:price)
    expected_1 = [650.0, 650.0, 600.0,
                  600.0, 600.0, 600.0,
                  600.0, 600.0, 600.0,
                  600.0, 550.0, 550.0]
    assert_equal expected_1, actual_1
  end
end
