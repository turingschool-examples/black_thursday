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
    @rep.
  end
end
