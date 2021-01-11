require 'minitest/autorun'
require 'minitest/pride'
require 'mocha/minitest'
require 'bigdecimal'
require './lib/standard_deviation'

class StandardDeviationTest < Minitest::Test
  include StandardDeviation

  def setup
   @test_obj = [10, 12, 23, 23, 16, 23, 21, 16]
   @test_obj.extend(StandardDeviation)
  end

  def test_it_has_attributes
    assert_equal 18, @test_obj.item_mean
    assert_equal 0.27428571428571428571e2, @test_obj.sample_variance
    assert_equal 5.24, @test_obj.standard_deviation
  end
end
