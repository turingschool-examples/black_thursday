require 'pry'
require_relative 'test_helper'
require_relative '../lib/sales_analyst'

class SalesAnalystTest < MiniTest::Test

  def setup
    @files = {:items => './test/data/items_test.csv',
              :merchants => './test/data/merchants_test.csv'}
  end

  def test_the_sales_analyst_exists
    se = SalesEngine.from_csv(@files)
    sa = SalesAnalyst.new(se)
  end

  def test_average_items_per_merchant_works
    se = SalesEngine.from_csv(@files)
    sa = SalesAnalyst.new(se)

    assert_equal 1, sa.average_items_per_merchant
  end

  def test_average_items_per_merchant_standard_deviation_works
    se = SalesEngine.from_csv(@files)
    sa = SalesAnalyst.new(se)

    actual_1 = sa.create_items_per_merchant_hash.keys
    actual_2 = sa.create_items_per_merchant_hash.values

    assert_equal [0, 1, 2, 3, 4], actual_1
    assert_equal [1, 0, 0, 0, 0], actual_2
  end

  def test_average_items_per_perchant_standard_dev
    se = SalesEngine.from_csv(@files)
    sa = SalesAnalyst.new(se)

    sa.stubs(:create_items_per_merchant_hash).returns({0 => 3, 1 => 4, 2 => 5})

    actual = sa.average_items_per_merchant_standard_deviation

    assert_equal 1, actual
  end
end
