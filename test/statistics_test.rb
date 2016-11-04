require_relative 'test_helper'
require_relative '../lib/statistics'

class StatisticsTest < Minitest::Test
  
  include Statistics

  def setup
    @array =  [
      7, 4, 4, 19, 12, 16, 19, 19, 18, 2, 2, 10, 
      1, 16, 8, 19, 10, 12, 7, 10, 20, 4, 2, 12, 
      18, 14, 4, 14, 17, 16, 6, 3, 11, 14, 13, 7, 
      1, 9, 20, 4, 14, 8, 1, 20, 11, 11, 2, 16, 9, 9
    ]
    @average = 10.5
  end

  def test_it_exists
    assert Statistics
  end

  def test_it_finds_squared_difference_between_unit_and_average
    assert_equal 36.0, squared_distance_from_average(4, 10)
  end

  def test_sum_of_squared_distances_finds_sum
    assert_equal 1802.5, std_dev_numerator(@array)
  end

  def test_std_dev_denominator_returns_n_minus_one
    assert_equal 49.0, std_dev_denominator(@array)
  end

  def test_standard_deviation_finds_it
    assert_equal 6.07, standard_deviation(@array)
  end

  def test_compare_with_std_dev
    assert_equal 1, compare_with_std_dev(@array, :more, 1)
  end


end
