require './test/test_helper'
require './lib/statistics'

class StatisticsTest < Minitest::Test
  include Statistics

  def test_it_can_find_mean_that_is_a_float
    a = [1, 3, 5, 7, 9]
    assert_equal 5.0, find_mean(a)
    assert_instance_of Float, find_mean(a)
  end

  def test_it_can_find_standard_deviation
    a = [3,4,5]
    assert_equal 1.0, standard_deviation(a)
    b = [9, 2, 5, 4, 12, 7]
    assert_equal 3.62, standard_deviation(b)
  end
end
