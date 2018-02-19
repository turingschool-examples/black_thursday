require_relative 'test_helper'
require_relative '../lib/sales_analyst'
require_relative '../lib/sales_engine'

class SalesAnalystTest < Minitest::Test
  def setup
    @se = SalesEngine.from_csv(
      items:     './test/fixtures/item_repository_abreviated.csv',
      merchants: './test/fixtures/merchants_list_truncated.csv'
    )
    @sales_analyst = SalesAnalyst.new(@se)
  end

  def test_it_exists_and_sales_engine_argument
    assert_instance_of SalesAnalyst, @sales_analyst
    assert_equal @se, @sales_analyst.sales_engine
  end

  def test_for_items_per_merchant
    assert_equal [2, 3, 4, 5, 6, 7], @sales_analyst.items_per_merchant
  end

  def test_for_average_items_per_merchant
    assert_equal 2.33, @sales_analyst.average_items_per_merchant
  end

  def test
end
