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
  
  
end