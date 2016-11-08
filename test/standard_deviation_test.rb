require_relative 'test_helper'
require './lib/standard_deviation'
require './lib/analyst_helper'
require './lib/analyst_operations'

class StandardDeviationTest < Minitest::Test

  def setup
      se = SalesEngine.from_csv({
      :items     => "./fixtures/items_small_list.csv",
      :merchants => "./fixtures/merchant_smaller_list.csv",
      :invoices  => "./fixtures/invoices_small_list.csv"
    })
    @sa = SalesAnalyst.new(se)
  end

  def test_sum_adds_correctly
    assert_equal 9, @sa.sum([2,3,4])
  end

  def test_sample_variance
    assert_equal 1.0, @sa.sample_variance([2,3,4])
  end

  def test_standard_deviation
    assert_equal 3.0550504633038935, @sa.standard_deviation([2,8,4])
  end

  def test_average_price_per_item_deviation
    assert_equal 55.22, @sa.average_price_per_item_deviation
  end

  def test_item_number_plus_one_deviation
    assert_equal 0.66, @sa.item_number_plus_one_deviation
  end

  def test_two_standard_deviations_away_in_price
    assert_equal 115.11, @sa.two_standard_deviations_away_in_price.to_f
  end

  def test_one_standard_deviation_above_invoice_average
    assert_equal 0.0, @sa.one_standard_deviation_above_invoice_average
  end

  def test_one_standard_deviation_below_invoice_average
    assert_equal 0.0, @sa.one_standard_deviation_below_invoice_average
  end

  def test_one_standard_deviation_above_mean_for_weekdays
    assert_equal 2.25, @sa.one_standard_deviation_above_mean_for_weekdays
  end

end