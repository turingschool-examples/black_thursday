require './test/test_helper'
require './lib/maths.rb'

class MathsTest < Minitest::Test
  include Maths

  def test_it_squares
    assert_equal 0, square(0.to_d)
    assert_equal 25, square(5.to_d)
    assert_equal 121, square(11.to_d)
  end

  def test_it_sums
    assert_equal 0, sum([0.to_d, 0.to_d])
    assert_equal 10.to_d, sum([1.to_d, 2.to_d, 3.to_d, 4.to_d])
    assert_equal 100.to_d, sum([10.to_d, 20.to_d, 30.to_d, 40.to_d])
  end

  def test_it_calcs_mean
    assert_equal 0, mean([0.to_d, 0.to_d])
    assert_equal 2.5.to_d, mean([1.to_d, 2.to_d, 3.to_d, 4.to_d])
    assert_equal 25.to_d, mean([10.to_d, 20.to_d, 30.to_d, 40.to_d])
  end

  def test_it_cals_percent
    assert_equal 10, percent(10.to_d, 100.to_d)
    assert_equal 25, percent(25.to_d, 100.to_d)
    assert_equal 9.5, percent(95.to_d, 1000.to_d)
  end

  def test_subtract_mean
    actual = subtract_mean([3.to_d, 4.to_d, 5.to_d])
    expected = [-1, 0, 1]
    assert_equal expected, actual
  end

  def test_squares
    actual = squares([2.to_d, 3.to_d, 4.to_d])
    expected = [4.to_d, 9.to_d, 16.to_d]
    assert_equal expected, actual
  end

  def test_sample
    actual = sample([2.to_d, 3.to_d, 4.to_d])
    expected = 4.5
    assert_equal expected, actual
  end

  def test_standard_deviation
    actual = standard_deviation([600.to_d, 470.to_d, 170.to_d, 430.to_d, 300.to_d])
    assert_equal 164.71, actual
    assert_equal Float, actual.class
  end
  
end
