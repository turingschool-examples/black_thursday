require_relative "test_helper"
require_relative "../lib/standard_deviation"

class StandardDeviationTest < Minitest::Test
  include StandardDeviation

  def test_sum
    assert_equal 6, [1,2,3].sum
  end

end
