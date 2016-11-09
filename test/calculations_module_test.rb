require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/calculations_module'
require_relative "../test/test_helper"

class CalculationsTest < Minitest::Test
include Calculations
    def test_it_can_sum
      assert_equal 48, sum([1, 7, 11, 29])
    end
    def test_it_can_find_mean
      assert_equal 33, mean([24, 15, 9, 36, 81])
    end
    def test_it_can_find_standard_deviation
      assert_equal 164.71, standard_deviation([600, 470, 170, 430, 300])
    end
    
end