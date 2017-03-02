require_relative 'test_helper'
require_relative '../lib/sales_analyst'

class SalesAnalystTest < Minitest::Test

  def setup
    @se = SalesEngine.from_csv({:items => "./data/items.csv", :merchants => "./data/merchants.csv", :invoices => "./data/invoices.csv", })
    @sa = SalesAnalyst.new(@se)
  end

  def test_it_exists
    sa = SalesAnalyst.new(@se)
    assert_instance_of SalesAnalyst, sa
  end

  def test_that_average_items_per_merchant
    assert_equal 2.88, @sa.average_items_per_merchant
  end

  def test_standard_deviation
    collection = [1, 2, 3, 4, 5, 6, 7]
    assert_equal 2.16, @sa.standard_deviation(collection)
  end

  def test_average_items_per_merchant_standard_deviation
    assert_equal 3.26, @sa.average_items_per_merchant_standard_deviation
  end

  def test_merchants_with_high_item_count
    high_count = @sa.merchants_with_high_item_count
    assert_instance_of Array, high_count
    assert_equal "Keckenbauer", high_count[0].name
  end

  def test_average_item_price_for_merchant
    assert_instance_of BigDecimal, @sa.average_item_price_for_merchant(12334174)
    assert_equal 30.0, @sa.average_item_price_for_merchant(12334174)
  end

  def test_average_of_average_price
    se = SalesEngine.from_csv({:items => "./data/items_fixture.csv", :merchants => "./data/merchants_fixture.csv" })
    sa = SalesAnalyst.new(se)
    assert_instance_of BigDecimal, sa.average_average_price_per_merchant
    assert_equal 37.01, sa.average_average_price_per_merchant
  end

  def test_golden_items
    se = SalesEngine.from_csv({:items => "./data/items_fixture.csv", :merchants => "./data/merchants_fixture.csv" })
    sa = SalesAnalyst.new(se)
    golden = sa.golden_items
    assert_instance_of Array, golden
    assert_instance_of Item, golden[0]
    assert_equal "Peanut", golden[0].name
    assert_equal "Crown jewels", golden[1].name
    assert_equal "Iphone 12", golden[2].name
  end

  def test_standard_deviation_for_price
    assert_equal 2900.99, @sa.standard_deviation_for_price
  end

  def test_average_invoices
    assert_equal 10.49, @sa.average_invoices_per_merchant
  end

  def test_average_invoices_sd
    assert_equal 3.29, @sa.average_invoices_per_merchant_standard_deviation
  end

  def test_top_merchants_by_invoice
    top = @sa.top_merchants_by_invoice_count
    assert_instance_of Array, top
    assert_instance_of Merchant, top[0]
  end

  def test_bottom_merchant_by_invoice
    bottom = @sa.bottom_merchants_by_invoice_count
    assert_instance_of Array, bottom
    assert_instance_of Merchant, bottom[0]
  end

  def test_top_days_by_invoice
    assert_equal ["Wednesday"], @sa.top_days_by_invoice_count
  end

  def test_invoice_status_returns_percentage
    assert_equal 56.95, @sa.invoice_status(:shipped)
    assert_equal 29.55, @sa.invoice_status(:pending)
    assert_equal 13.5, @sa.invoice_status(:returned)
  end

  def test_total_revenue_by_date
    date = Time.parse("2009-02-07")
    incorrect_date = Time.now
    assert_equal 21067.77, @sa.total_revenue_by_date(date)
    assert_equal 0, @sa.total_revenue_by_date(incorrect_date)
  end

  def test_top_revenue_earners
    top = @sa.top_revenue_earners(10)
    refute top.empty?
    assert_equal 10, top.count
    assert_instance_of Merchant, top[0]
  end

  def test_top_revenue_earners_returns_20_without_argument
    assert_equal 20, @sa.top_revenue_earners.count
  end

  def test_merchants_ranked_by_revenue
    ranked = @sa.merchants_ranked_by_revenue
    assert_equal 475, ranked.count
    assert_equal ranked[0..19], @sa.top_revenue_earners
    assert_equal ranked[-20..-1], @sa.bottom_revenue_earners
  end

  def test_bottom_revenue_earners
    bottom = @sa.bottom_revenue_earners(10)
    refute bottom.empty?
    assert_equal 10, bottom.count
    assert_instance_of Merchant, bottom[0]
  end

  def test_top_revenue_earners_returns_20_without_argument
    assert_equal 20, @sa.bottom_revenue_earners.count
  end

  def test_merchants_with_pending_invoices
    pending = @sa.merchants_with_pending_invoices
    assert_instance_of Array, pending
    assert_instance_of Merchant, pending[0]
    assert_equal 467, pending.count
  end

  def test_merchants_with_only_one_item
    ones = @sa.merchants_with_only_one_item
    assert_instance_of Array, ones
    assert_instance_of Merchant, ones[0]
    assert_equal 243, ones.count
  end

  def test_merchants_with_only_one_item_by_month
    ones = @sa.merchants_with_only_one_item_registered_in_month("February")
    assert_instance_of Array, ones
    assert_instance_of Merchant, ones[0]
    assert_equal 19, ones.count
  end

  def test_revenue_by_merchant
    total = @sa.revenue_by_merchant(12334135)
    assert_instance_of BigDecimal, total
    assert_equal 86389.07, total.to_f
  end

  def test_most_sold_item_for_merchant
    most_sold = @sa.most_sold_item_for_merchant(12334189)
    assert_instance_of Item, most_sold[0]
    assert_equal 1, most_sold.length
    assert_equal [@se.items.find_by_name("Adult Princess Leia Hat")], most_sold

    other_most_sold = @sa.most_sold_item_for_merchant(12335916)
    assert_instance_of Item, other_most_sold[0]
    assert_equal 1, other_most_sold.length
    assert_equal [@se.items.find_by_id(263452497)], other_most_sold
  end

  def test_least_sold_item_for_merchant
    least_sold = @sa.least_sold_item_for_merchant(12334189)
    assert_instance_of Item, least_sold[0]
    assert_equal 1, least_sold.length

    other_least_sold = @sa.least_sold_item_for_merchant(12335916)
    assert_instance_of Item, other_least_sold[0]
    assert_equal 1, other_least_sold.length
    assert_equal [@se.items.find_by_id(263452497)], other_least_sold
  end

  def test_best_item_for_merchant
    assert_instance_of Item, @sa.best_item_for_merchant(12334189)
    assert_equal 263516130, @sa.best_item_for_merchant(12334189).id
  end

  def test_sold_zero
    refute @sa.sold_zero(263549302)
    assert @sa.sold_zero(235335435)
    refute @sa.sold_zero(263549938)
    assert @sa.sold_zero(235225435)
  end
end