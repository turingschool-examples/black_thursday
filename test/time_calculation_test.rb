require_relative 'test_helper'
require_relative '../lib/time_calculation'

class TimeCalculationTest < MiniTest::Test
  include TimeCalculation

  def test_can_get_day_of_week_from_time_object
    assert_equal "Friday", day_of_the_week('2017-11-03')
  end
  
end
