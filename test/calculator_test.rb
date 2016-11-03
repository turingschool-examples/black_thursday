require_relative 'test_helper'
require_relative '../lib/calculator'

class CalculatorTest < Minitest::Test

  include Calculator

  def test_it_calculates_average
    set = [600, 470, 170, 430, 300]
    assert_equal 394, average(set)
  end

  def test_it_returns_0_when_finding_average_of_empty_set
    set = []
    assert_equal 0, average(set)
  end

  def test_it_calculates_standard_deviation
    set = [600, 470, 170, 430, 300]
    assert_equal 164.71, standard_deviation(set).round(2)
  end

  def test_it_returns_0_when_calculating_standard_deviation_of_empty_set
    set = []
    assert_equal 0, standard_deviation(set)
  end

end
