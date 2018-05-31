require './test_helper'



class MathMethodsTest < MiniTest::Test

  def setup
    @tester = Mock.new
  end

  def test_it_can_get_mean
    assert_equal 4, @tester.mean([3,4,5])
  end
end
