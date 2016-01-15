require_relative 'test_helper'
require_relative '../lib/sales_analyst'
# require 'bigdecimal'

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
    expected = 2.9 #remove the hardcode
    submitted = @sa.average_items_per_merchant

    assert_equal expected, submitted
  end

  def test_calc_items_per_merchant_standard_deviation
    std_deviation = 3.3 #remove the hardcode
    testing = @sa.calc_items_per_merchant_standard_deviation

    assert_equal std_deviation, testing

    # result of inject
    # => 5035.149999999971

    # result of above divided by .count
    # => Variance (Population Standard Deviation)
    # => 10.600315789473624

    # std_deviation
    # => 3.25581261584165
  end

  def test_find_percentage_of_those_who_fall_one_std_dev_below
    #BETH
    # standard error: standard_deviation / square root of (count of items)
    # standard error == 0.15
    # everyone below == 2.9 - 0.15 = 2.7ish
    #BETH

    total = @sa.total_number_of_merchants
    percentage = 0.158
    expected = total * percentage
    submitted = @sa.find_percentage_of_those_who_fall_one_std_dev_below

    assert_equal expected, submitted
  end

  def test_merchants_below_one_std_dev
    expected = @sa.find_percentage_of_those_who_fall_one_std_dev_below.round(0)
    submitted = @sa.merchants_below_one_std_dev

    assert_equal expected.round(0), submitted.count
  end

  def test_calc_items_per_merchant_standard_deviation
    skip

    @sa.merchants_with_low_item_count

    fifteen_percent = @sa.find_percentage_of_those_who_fall_one_std_dev_below

    expected = 2.9
    submitted = @sa.calc_items_per_merchant_standard_deviation

    assert_equal expected, submitted
  end


  def test_merchants_with_low_item_count
    skip
    # returns array of merchants
    # that are more than one standard_deviation (0.825) below
    # the average number of products
  end

  def test_average_item_price_for_merchant
    skip
    # argument has you provide a specific merchant_id
    merchant_id = 12334194
    submitted = "nope"
    # binding.pry
    expected = @sa.average_item_price_for_merchant(merchant_id.to_s)

    # average_item_price_for_merchant(merchant_id)
    # =>
    # => BigDecimal of average price is returned for that specific merchant

    assert_equal first, first
  end

  def test_average_price_per_merchant
    skip
    # no arg
    # => BigDecipmal of the average price across ALL merchants
  end

  def test_golden_items
    skip
    # find items that are two standard_deviations ABOVE the average_item_price
  end

end
