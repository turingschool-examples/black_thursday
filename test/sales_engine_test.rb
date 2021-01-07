require 'CSV'
require './test/test_helper'

class SalesEngineTest < Minitest::Test
  def setup
    data = {
            :items     => "./data/items.csv",
            :merchants => "./data/merchants.csv"
            }
    @engine = SalesEngine.new(data)
  end

  def test_it_exists
    assert_instance_of SalesEngine, @engine
  end
end
