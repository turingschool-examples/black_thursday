require_relative 'test_helper'
require_relative '../lib/sales_analyst'
require_relative '../lib/sales_engine'

class SATest < Minitest::Test
  def setup
    @data = {
      :items     => "./test/fixtures/items_sample.csv",
      :merchants => "./test/fixtures/merchants_sample.csv",
      :invoices => "./test/fixtures/invoices_sample.csv"
        }
    @sales_analyst = SalesAnalyst.new(SalesEngine.new(@data))
  end

  def test_avg_items
    assert_equal 2.63, @sales_analyst.average_items_per_merchant
  end

  def test_std_dev
    assert_equal 3.16, @sales_analyst.average_items_per_merchant_standard_deviation
  end

  def test_mean_items_per_merchant
    item_array = [3,4,5]
    assert_equal 4, @sales_analyst.mean_items_per_merchant(item_array)
  end

end
