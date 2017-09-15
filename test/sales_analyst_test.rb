require_relative 'test_helper'
require_relative '../lib/sales_analyst'
require_relative '../lib/sales_engine'
require 'bigdecimal'

class SalesAnalystTest < Minitest::Test

  attr_reader :se,
              :sa

  def setup
    @se = SalesEngine.from_csv({
            :items => './test/fixtures/items_truncated_10.csv',
            :merchants => './test/fixtures/merchants_truncated_4.csv',
            })
    @sa = SalesAnalyst.new(se)
  end

  def test_it_exists
    assert_instance_of SalesAnalyst, sa
  end

  def test_average_items_per_merchant_returns_average
    assert_equal 2.5, sa.average_items_per_merchant
  end

  def test_average_items_per_merchant_standard_deviation_returns_standard_deviation
    assert_equal 1.73, sa.average_items_per_merchant_standard_deviation
  end

  def test_merchants_with_high_item_count_returns_merchants_array
    expected = [@se.merchants.find_by_id(12334123)]
    actual = sa.merchants_with_high_item_count

    assert_equal expected, actual
  end

  def test_average_item_price_for_merchant_returns_average_item_price_for_that_merchant
#TODO Ask why 5 is used vs a 4 in BigDecimal.new
    expected = BigDecimal.new((13000 + 40000 + 690 + 1490 + 14900)/100.0/5.0, 5)
    actual = sa.average_item_price_for_merchant(12334123)

    assert_equal expected, actual
  end

  def test_average_average_price_per_merchant_returns_average_item_price_across_all_merchants
    merchant_1_avg = sa.average_item_price_for_merchant(12334105)
    merchant_2_avg = sa.average_item_price_for_merchant(12334112)
    merchant_3_avg = sa.average_item_price_for_merchant(12334115)
    merchant_4_avg = sa.average_item_price_for_merchant(12334123)
    expected = (merchant_1_avg + merchant_2_avg + merchant_3_avg + merchant_4_avg)/4
    actual = sa.average_average_price_per_merchant

    assert_equal expected, actual
  end



end
