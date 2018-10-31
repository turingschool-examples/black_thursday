require './test/test_helper'
require './lib/statistics'
require './lib/repository'

class Repository
  include Statistics
end

class StatisticsTest < Minitest::Test
  def setup
    @rep = ItemRepository.new
  end
  def test_most_basic_standard_deviation
    assert_equal 1, @rep.standard_deviation(3,4,5)
  end
  def test_standard_deviation
    assert_equal 1.5275252316519465, @rep.standard_deviation(3,4,6)
  end
  def test_average
    assert_equal 4, @rep.average(3,4,5)
  end
end
