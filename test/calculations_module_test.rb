require 'minitest/autorun'
require 'minitest/pride'
require './lib/calculations_AK.rb'

class CalculationsTest < Minitest::Test
include Calculations

    def test_it_can_sum
      assert_equal 5, sum([1, 1, 1, 2])
    end

    def test_it_can_find_mean
      assert_equal 2, mean([3, 1, 2])
    end

    def test_it_can_find_standard_deviation
      assert_equal 164.71, standard_deviation([600, 470, 170, 430, 300])
    end

    
end
