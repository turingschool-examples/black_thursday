require 'minitest/autorun'
require 'minitest/pride'
require './lib/calculations_module'

class DummyTest < Minitest::Test
include Calculations

    def test_it_can_sum
    calc = Calculations.new
    assert_equal 4, calc.sum
    end

end