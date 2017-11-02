require_relative './test_helper'
require './lib/sales_analyst'

class SalesAnalystTest < Minitest::Test
  attr_reader :se,
              :sa

  def setup
    @se = SalesEngine.from_csv({
      :items => "./test/fixture/item_truncated.csv",
      :merchants => './test/fixture/merchants_truncated.csv',
      :invoices => './test/fixture/invoice_truncated.csv'}
    )
    @sa = SalesAnalyst.new(se)
  end

  def test_initialize_sales_analyst
    assert_instance_of SalesAnalyst, sa
  end

  def test_it_can_determine_average_items_per_merchant
    assert_equal 2, sa.average_items_per_merchant
  end

  def test_it_can_determine_standard_deviation_items_per_merchant

    assert_equal 1.0, sa.standard_deviation_items_per_merchant
  end

  def test_count_all_items_for_each_merchant
    assert_equal [1,1,1,1,4], sa.count_all_items_for_each_merchant
  end

  def test_determine_merchants_with_most_items
    result = sa.merchants_with_high_item_count
    assert_equal "Madewithgitterxx", result[0].name
  end

  def test_determines_average_price_for_merchants
    result = sa.average_item_price_for_merchant(12334185)
    assert_equal 18462.5, result
  end

  def test_determines_average_average_price_per_merchants
    result = sa.average_average_price_per_merchant
    assert_equal 8892.5, result
  end

  def test_it_can_determine_standard_deviation_items_price
    result = sa.standard_deviation_of_item_price
    assert_equal 20331, result
  end

  def test_it_can_determine_the_golden_items
    result = sa.golden_items
    assert_equal 1, result.count
    assert_equal 'Free standing Woden letters', result[0].name
  end
end
