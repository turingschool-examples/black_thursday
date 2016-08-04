require './test/test_helper'
require './lib/analyst_math'

class AnalystMathTest < Minitest::Test
  def test_method_average_returns_float
    numbers = [22, 40, 12, 19, 30]
    assert_equal 24.6, AnalystMath.average(numbers)
    numbers = [50, 2, 5, 7, 11, 4444]
    assert_equal 753.17, AnalystMath.average(numbers)
  end

  def test_method_standard_deviation_returns_float
    numbers = [22, 40, 12, 19, 30]
    assert_equal 10.76, AnalystMath.standard_deviation(numbers)
    numbers = [50, 2, 5, 7, 11, 4444]
    assert_equal 1808.22, AnalystMath.standard_deviation(numbers)
  end

  def test_method_std_devs_out_returns_float
    numbers = [22, 40, 12, 19, 30]
    assert_equal 35.36, AnalystMath.std_devs_out(numbers, 1)
    assert_equal 24.6, AnalystMath.std_devs_out(numbers, 0)
    assert_equal 13.84, AnalystMath.std_devs_out(numbers, -1)
  end
end
