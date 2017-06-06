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

    assert_equal 41, actual
  end

  def test_total_merchant
    actual = @sa.sales_engine.merchants.all_merchant_data.count

    assert_equal 50, actual
  end

  def test_the_average_item_per_merchant
    items_per_merch =
    @sa.sales_engine.merchants.all_merchant_data.map{|merchant| merchant.items.count}
    actual = items_per_merch.reduce{|sum, num| sum + num}.to_f / items_per_merch.count

    assert_equal 0.52, actual
  end

  def test_that_average_method_rounds_correctly
    actual = @sa.average_items_per_merchant

    assert_equal 0.52, actual
  end

  def test_array_of_item_count_per_merchant
    items_array = @sa.sales_engine.merchants.all_merchant_data.map do |merchant|
      merchant.items.count
    end

    assert_equal 50, items_array.count
  end

  def test_standard_deviation_method
    mean = @sa.average_items_per_merchant
    sum = @sa.avg_items.reduce(0){|sum, num| sum + (num - mean)**2}
    actual = Math.sqrt(sum/(@sa.avg_items.count - 1)).round(2)

    assert_equal 1.76, actual
  end

  def test_merchants_with_high_item_count
    top_merchants = @sa.sales_engine.merchants.all_merchant_data.find_all do |merchant|
      merchant.items.count > (@sa.average_items_per_merchant +
      @sa.average_items_per_merchant_standard_deviation)
    end

    assert_equal 2, top_merchants.count
  end

  def test_average_item_price_for_merchant
    merch_items = @sa.sales_engine.item_output(12334105)
    item_prices = merch_items.map{|item| item.unit_price.to_i}
    avg_item_price = item_prices.reduce{|sum, num| sum + num}/ item_prices.count

    assert_equal 29, avg_item_price
  end

  def test_average_average_price_per_merchant
    merchants = @sa.sales_engine.merchants.all
    merch_ids = merchants.map do |merchant|
      merchant.id.to_i
    end
    avg_prices = []
    merch_ids.each do |merchant_id|
      if @sa.average_item_price_for_merchant(merchant_id) != nil
        avg_prices << @sa.average_item_price_for_merchant(merchant_id)
      end
    end
    actual = (avg_prices.reduce(:+) / avg_prices.count).round(2)

    assert_equal 75.82, actual.to_f
  end

  def test_average_item_price
    all_items = @sa.sales_engine.items.all
    all_item_prices = all_items.map{|item| item.unit_price}
    avg_item_price = all_item_prices.reduce{|sum, num| sum + num}.to_f/ all_item_prices.count

    assert_equal 174.44, avg_item_price.round(2)
  end

  def test_standard_deviation_of_prices
    mean = @sa.average_item_price_overall
    sum = @sa.all_item_prices.reduce(0){|sum, num| sum + (num - mean)**2}
    actual = Math.sqrt(sum/(@sa.all_item_prices.count - 1)).round(2)

    assert_equal 219.44, actual
  end

  def test_golden_items
    mean = @sa.average_item_price_overall
    actual = @sa.sales_engine.items.all_item_data.find_all do |item|
      (item.unit_price - mean) > (@sa.standard_deviation_of_prices * 2)
    end
    assert_equal 1, actual.count
  end

end
