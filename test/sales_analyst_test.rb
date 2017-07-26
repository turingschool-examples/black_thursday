require_relative '../test/test_helper'
require_relative '../lib/sales_analyst'
require_relative '../lib/sales_engine'

class SalesAnalystTest < Minitest::Test

  attr_reader :sa

  def setup
    sales_engine = SalesEngine.from_csv({
          :items => "./test/data/items_truncated.csv",
          :merchants => "./test/data/merchants_truncated.csv",
          :invoice_items => "./test/data/invoice_items_truncated.csv",
          :invoices => "./test/data/invoices_truncated.csv",
          :transactions => "./test/data/transactions_truncated.csv",
          :customers => "./test/data/customers_truncated.csv"
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
    merch_items = @sa.sales_engine.item_from_merch(12334105)
    item_prices = merch_items.map{|item| item.unit_price.to_i}
    avg_item_price = item_prices.reduce{|sum, num| sum + num}/ item_prices.count

    assert_equal 29, avg_item_price
  end

  def test_find_all_merchant_ids
    merchants = @sa.sales_engine.merchants.all
    actual = merchants.map do |merchant|
      merchant.id.to_i
    end
    actual = actual.count
    assert_equal 50, actual

    actual = actual.class
    assert_equal Fixnum, actual
  end

  def test_average_average_price_per_merchant
    avg_prices = []
    @sa.find_all_merchant_ids.each do |merchant_id|
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

  def test_average_invoices_per_merchant
    invoices_per_merch =
    @sa.sales_engine.merchants.all_merchant_data.map{|merchant| merchant.invoices.count}
    actual = invoices_per_merch.reduce{|sum, num| sum + num}.to_f / invoices_per_merch.count

    assert_equal 1.04, actual
  end

  def test_standard_deviation_of_invoices_per_merchant
    mean = @sa.average_invoices_per_merchant
    sum = @sa.invoices_per_merch.reduce(0){|sum, num| sum + (num - mean)**2}
    actual = Math.sqrt(sum/(@sa.invoices_per_merch.count - 1)).round(2)

    assert_equal 0.9, actual
  end

  def test_top_merchants_by_invoice_count
    mean = @sa.average_invoices_per_merchant
    actual = @sa.sales_engine.merchants.all_merchant_data.find_all do |merchant|
      (merchant.invoices.count - mean) > (@sa.average_invoices_per_merchant_standard_deviation * 2)
    end

    assert_equal 4, actual.count
    assert_equal Merchant, actual[0].class
  end

  def test_bottom_merchants_by_invoice_count
    mean = @sa.average_invoices_per_merchant
    actual = @sa.sales_engine.merchants.all_merchant_data.find_all do |merchant|
      (mean - merchant.invoices.count) > (@sa.average_invoices_per_merchant_standard_deviation*2)
    end

    assert_equal 0, actual.count
  end

  def test_average_sales_per_day
    invoice_dates = @sa.sales_engine.invoices.all_invoice_data.map do |invoice|
      invoice.created_at.strftime("%A")
    end
    day_count = invoice_dates.reduce(Hash.new(0)){|days, num| days[num] += 1; days}
    actual = day_count.values.reduce(:+)/ 7

    assert_equal 71, actual
  end

  def test_average_sales_per_day_std_dev
    mean = @sa.average_sales_per_day
    sum = @sa.day_count.values.reduce(0){|sum, num| sum + (num - mean)**2}
    actual = Math.sqrt(sum / 6).round(2)

    assert_equal 7.81, actual
  end

  def test_top_days_by_invoice_count
    mean = @sa.average_sales_per_day
    actual = @sa.day_count.find_all do |day, num|
      (num - mean) > @sa.average_sales_per_day_standard_deviation
    end.flatten
    actual = actual.select.with_index{|item, index| index.even?}

    assert_equal ["Sunday"], actual
  end

  def test_invoice_status
    invoice_status =
    @sa.sales_engine.invoices.all.map{|invoice| invoice.status}
    invoice_status =
    invoice_status.reduce(Hash.new(0)){|status, num| status[num] += 1; status}
    sum = invoice_status.values.inject(:+)
    actual = invoice_status.each_with_object(Hash.new(0)) do |(stat, num), hash|
      hash[stat] = num * 100.0 / sum
    end
    expected = {:pending=>32.4, :shipped=>54.4, :returned=>13.2}

    assert_equal expected, actual

    actual = @sa.invoice_status(:pending)

    assert_equal 32.4, actual
  end

end
