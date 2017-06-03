require_relative '../test/test_helper'
require_relative '../lib/sales_analyst'
require_relative '../lib/sales_engine'

class SalesAnalystTest < Minitest::Test

  attr_reader :sa

  def setup
    sales_engine = SalesEngine.from_csv({
      :items     => "./test/data/items_truncated.csv",
      :merchants => "./test/data/merchants_truncated.csv"
    })
    @sa = SalesAnalyst.new(sales_engine)
  end

  def test_total_items
    actual = @sa.sales_engine.items.all_item_data.count

    assert_equal 17, actual
  end

  def test_total_merchant
    actual = @sa.sales_engine.merchants.all_merchant_data.count

    assert_equal 3, actual
  end

  def test_the_average_item_per_merchant
    actual = (@sa.sales_engine.items.all_item_data.count).to_f /
    (@sa.sales_engine.merchants.all_merchant_data.count).to_f

    assert_equal 5.666666666666667, actual
  end

  def test_the_average_item_per_merchant_method
    actual = @sa.average_items_per_merchant

    assert_equal 5.666666666666667, actual
  end


end
