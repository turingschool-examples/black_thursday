require './test/test_helper'
require './lib/mathematics_module'

class MathematicsModuleTest < Minitest::Test
  include Mathematics

  def setup
    @math = Mathematics.new
    @number_set = [3 ,5 ,8]
  end

  def math_module_can_calculate_standard_deviation
    std_dev = @math.calculate_standard_deviation(@number_set)

    assert_equal 2.52, std_dev
  end
end
