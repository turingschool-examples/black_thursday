require_relative 'test_helper'
require_relative './../lib/sales_engine'
require_relative './../lib/sales_analyst'

class SalesAnalystTest < Minitest::Test
  attr_reader :engine,
              :analyst

  def setup
    @engine = SalesEngine.from_csv(
      items: './data/items.csv',
      merchants: './data/merchants.csv',
      invoices: './test/fixtures/truncated_invoices.csv'
    )

    @analyst =SalesAnalyst.new(@engine)
  end

  def test_it_exists
    assert_instance_of SalesAnalyst, analyst
  end

  def test_it_can_calculate_average_items_per_merchant
    assert_equal 2.88, analyst.average_items_per_merchant
  end

  def test_can_find_average_item_price_for_merchant
    result = analyst.average_item_price_for_merchant(12334185)
    assert_equal 10.78, result
  end

  def test_can_find_average_average_price_per_merchant
    result = analyst.average_average_price_per_merchant

    assert_equal 0.35029e3, result
  end
end
