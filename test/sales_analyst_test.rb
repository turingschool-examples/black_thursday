require_relative 'test_helper'
require_relative '../lib/sales_analyst'

class SalesAnalystTest < Minitest::Test

  def setup
    @se = SalesEngine.from_csv({:merchants => './data/merchants.csv',
                               :items => './data/items.csv'})
    @sa = SalesAnalyst.new(@se)
  end

  def test_sales_analyst_exists
    assert_kind_of SalesAnalyst, @sa
  end

  def test_average_items_per_merchant
    expected = 2.9
    submitted = @sa.average_items_per_merchant

    assert_equal expected, submitted
  end

  def test_calc_items_per_merchant_standard_deviation
    std_deviation = 3.3
    testing = @sa.calc_items_per_merchant_standard_deviation

    assert_equal std_deviation, testing

    # result of inject
    # => 5035.149999999971

    # result of above divided by .count
    # => 10.600315789473624

    # std_deviation
    # => 3.25581261584165
  end

  def test_average_items_per_merchant_standard_deviation
    skip
    expected = 2.9
    submitted = @sa.combine_merchant_item_count
    ok = @sa.average_items_per_merchant_standard_deviation

    assert_equal expected, submitted
  end

  def test_merchants_with_low_item_count
    # returns array of merchants that are more than one standard_deviation below
    # the average number of products
  end

  def test_average_items_price_for_merchant
    # argument has you provide a specific merchant_id
    # => BigDecimal of average price is returned for that specific merchant
  end

  def test_average_price_per_merchant
    # no arg
    # => BigDecipmal of the average price across ALL merchants
  end

  def test_golden_items
    # find items that are two standard_deviations ABOVE the average_item_price
  end

end
