require_relative 'test_helper'
require_relative '../lib/analyzer'

# Analyzer Test class
class AnalyzerTest < Minitest::Test
  include Analyzer

  def test_average
    assert_equal 2, average(4, 2)
  end

  def test_standard_deviation
    set = [3, 4, 5]
    assert_equal 1, standard_deviation(set, average(set.reduce(:+), set.count))
  end
end
