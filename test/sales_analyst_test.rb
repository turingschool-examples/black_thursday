require './test/helper'

class SalesAnalystTest < Minitest::Test

  def setup
   se = SalesEngine.from_csv({
   :merchants     => './test/fixtures/merchants_fixtures.csv',
   :items         => './test/fixtures/items_fixtures.csv',
   :invoices      => './test/fixtures/invoices_fixtures.csv',
   :invoice_items => './test/fixtures/invoice_items_fixtures.csv'
                           })
   @sa = se.analyst
  end

  def test_it_exists
   assert_instance_of SalesAnalyst, @sa
  end

  def test_it_returns_average_items_per_merchant
    result = @sa.average_items_per_merchant
    assert_equal 0.77, result
    assert_equal Float, result.class
  end

  def test_it_returns_average_items_per_merchant_standard_deviation
    result = @sa.average_items_per_merchant_standard_deviation
    assert_equal Float, result.class
    assert_equal 0.98, result
  end

  def test_it_can_return_which_merchants_sell_the_most_items
    result = @sa.merchants_with_high_item_count
    assert_instance_of Array,result
    assert_equal 0, result.count
  end

  def test_it_can_return_average_item_price_per_merchant
    result = @sa.average_item_price_for_merchant(12334105)
    assert_instance_of BigDecimal,result
    assert_equal  0.2999e2,result
  end

  def test_it_returns_the_average_price_for_all_merchants
    result = @sa.average_average_price_per_merchant
    assert_instance_of BigDecimal, result
    assert_equal 0.5808e2,result
  end

  def test_item_price_std_dev
    result = @sa.item_price_std_dev
    assert_equal 124.97,result
  end

  def test_it_can_return_golden_items
    result = @sa.golden_items
    assert_instance_of Array, result
    assert_equal 1,result.count
    assert_equal 0.4e3, result.first.unit_price
  end

  def test_it_can_get_average_invoices_per_merchant
    result = @sa.average_invoices_per_merchant
    assert_equal 1.08, result
  end

  def test_it_has_average_invoices_per_merchant_standard_deviation
    result = @sa.average_invoices_per_merchant_standard_deviation
    assert_equal 0.56, result
  end

  def test_it_can_return_the_top_performers_two_deviations_above_mean
    result = @sa.top_merchants_by_invoice_count
    assert_equal [], result
  end

  def test_lowest_performers_two_deviations_below_mean
    result = @sa.bottom_merchants_by_invoice_count
    assert_equal [], result
  end

  def test_which_days_of_the_week_we_see_the_most_sales
    result = @sa.top_days_by_invoice_count
    assert_equal [], result
  end

  def test_percentage_of_invoices_not_shipped
    result    = @sa.invoice_status(:pending)
    result_2  = @sa.invoice_status(:shipped)
    result_3  = @sa.invoice_status(:returned)

    assert_equal 0, result
    assert_equal 0, result_2
    assert_equal 0, result_3
  end
end
