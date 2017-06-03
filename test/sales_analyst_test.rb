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
    items_per_merch =
    @sa.sales_engine.merchants.all_merchant_data.map{|merchant| merchant.items.count}
    actual = items_per_merch.reduce{|sum, num| sum + num}.to_f / items_per_merch.count

    assert_equal 0.3333333333333333, actual
  end

  def test_that_average_method_rounds_correctly
    actual = @sa.average_items_per_merchant

    assert_equal 0.33, actual
  end

  def test_array_of_item_count_per_merchant
    items_array = @sa.sales_engine.merchants.all_merchant_data.map do |merchant|
      merchant.items.count
    end

    assert_equal 3, items_array.count
  end

  def test_standard_deviation_method
    mean = @sa.average_items_per_merchant
    sum = @sa.avg_items.reduce(0){|sum, num| sum + (num - mean)**2}
    actual = Math.sqrt(sum/(@sa.avg_items.count - 1)).round(2)

    assert_equal 0.58, actual
  end

end
