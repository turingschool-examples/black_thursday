require './test/test_helper'
require './lib/statistics'
require './lib/repository'

class Repository
  include Statistics
end

class StatisticsTest < Minitest::Test
  def setup
    @rep = Repository.new
  end
  def test_most_basic_standard_deviation
    skip
    assert_equal 1, @rep.stand_deviation(3,4,5)

  end
  def test_average
    assert_equal 4, @rep.average(3,4,5)
  end


end
