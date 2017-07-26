require 'minitest'
require 'minitest/autorun'
require 'minitest/emoji'
require './lib/calculator'

class CalculatorTest < Minitest::Test

  def setup
    @calc = Calculator.new
  end

  def test_sum_of_array
    assert_equal 9, @calc.sum([2, 3, 4])
    assert_equal 42, @calc.sum([7, 14, 21])
    assert_equal 9.0, @calc.sum([2.5, 4.5, 2])
  end

  def test_mean_value_of_array
    assert_equal 3, @calc.mean([2, 3, 4])
    assert_equal 14, @calc.mean([7, 14, 21])
    assert_equal 3.0, @calc.mean([2.5, 4.5, 2])
  end

  def test_difference_method_on_array
    assert_equal [1, 0, 1], @calc.difference([2, 3, 4])
    assert_equal [49, 0, 49], @calc.difference([7, 14, 21])
    assert_equal [0.25, 2.25, 1.0], @calc.difference([2.5, 4.5, 2])
  end

  def test_standard_deviance_on_array
    assert_equal 0, @calc.standard_deviance([10, 10, 10])
    assert_equal 1.0, @calc.standard_deviance([2, 3, 4])
    assert_equal 7.0, @calc.standard_deviance([7, 14, 21])
    assert_equal 1.323, (@calc.standard_deviance([2.5, 4.5, 2])).round(3)
  end

end
