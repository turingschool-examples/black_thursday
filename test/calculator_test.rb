require './test/test_helper'

class CalculatorTest < Minitest::Test

  include Calculator


  def test_it_calculates_average
    set = [2, 3, 5, 7, 9]
    assert_equal 5, average(set)
  end

  def test_standard_deviation
    skip
    assert 3, calc.std_dev
  end
end
