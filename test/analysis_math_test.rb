require_relative './test_helper'
require_relative '../lib/analysis_math'

class DummyTestClass
  include AnalysisMath
end

class AnalysisMathTest < Minitest::Test

  def test_it_calculates_sum
    dummy = DummyTestClass.new
    array = [1,2,3,4,5]
    assert_equal 15, dummy.sum(array)
    assert_equal BigDecimal, dummy.sum(array).class
  end

  def test_it_calculates_average
    dummy = DummyTestClass.new
    array = [1,2,3,4,5]
    assert_equal 3, dummy.mean(array)
    assert_equal 2502.5, dummy.mean([5000,5])
    assert_equal BigDecimal, dummy.mean([1,2]).class
  end

  def test_it_calculates_variance
    dummy = DummyTestClass.new
    array = [1,2,3,4,5]
    assert_equal 2.5, dummy.variance(array)
    assert_equal BigDecimal, dummy.variance(array).class
  end

  def test_it_calculates_standard_deviation
    dummy = DummyTestClass.new
    array = [1,2,3,4,5]
    assert_equal 1.58114, dummy.standard_deviation(array)
    assert_equal BigDecimal, dummy.standard_deviation(array).class
  end

end
