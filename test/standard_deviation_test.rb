require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/standard_deviation'

class StandardDeviationTest < Minitest::Test

  def test_it_exists
    calculator = StandardDeviation.new([40.0, 30.0, 45.0, 50.0, 62.0, 77.0, 40.0, 55.0, 32.0, 49.0, 51.0])

    assert_instance_of StandardDeviation, calculator
  end

  def test_the_data_attribute
    calculator = StandardDeviation.new([40.0, 30.0, 45.0, 50.0, 62.0, 77.0, 40.0, 55.0, 32.0, 49.0, 51.0])

    assert_equal [40.0, 30.0, 45.0, 50.0, 62.0, 77.0, 40.0, 55.0, 32.0, 49.0, 51.0], calculator.data
  end

  def test_the_data_can_be_averaged
    calculator = StandardDeviation.new([40.0, 30.0, 45.0, 50.0, 62.0, 77.0, 40.0, 55.0, 32.0, 49.0, 51.0])

    assert_equal 48.2727, calculator.average.round(4)
  end

  def test_the_sum_the_squares_of_differences
    calculator = StandardDeviation.new([40.0, 30.0, 45.0, 50.0, 62.0, 77.0, 40.0, 55.0, 32.0, 49.0, 51.0])

    assert_equal 1816.1818, calculator.sum_squares_differences.round(4)
  end

  def test_the_final_calculation
    calculator = StandardDeviation.new([40.0, 30.0, 45.0, 50.0, 62.0, 77.0, 40.0, 55.0, 32.0, 49.0, 51.0])

    assert_equal 13.4766, calculator.calculate.round(4)
  end
end
