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

  def test_avg_item_per_merchant
    assert_equal 0.1117e2, @sales_analyst.average_item_price_for_merchant(12334185)
  end

  def test_avg_avg
    assert_equal 0.13847e3, @sales_analyst.average_average_price_per_merchant
  end

  def test_golden_items
    golden = @sales_analyst.golden_items.map { |item| item.id }
    expected = []
    assert_equal expected, golden
  end

end
