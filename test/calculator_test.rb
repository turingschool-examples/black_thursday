require 'minitest/autorun'
require 'minitest/pride'
require './lib/calculator'
require 'simplecov'

SimpleCov.start

class CalculatorTest < Minitest::Test

  include Calculator

  def test_it_exists
    assert_instance_of Module, Calculator
  end

  def test_average_method
    set = [2, 3, 4, 5, 6]
    assert_equal 4.00, average(set)
  end

  def test_standard_deviation
    set = [2, 3, 4, 5, 6]
    assert_equal 1.58, standard_deviation(set)
  end

  def test_one_standard_deviation_above_mean
    set = [2, 3, 4, 5, 6]
    assert_equal 5.58, one_standard_deviation_above_mean(set)
  end

  def test_two_standard_deviations_above_mean
    set = [2, 3, 4, 5, 6]
    assert_equal 7.16, two_standard_deviations_above_mean(set)
  end
end