require 'CSV'
require './test_helper'

class SalesEngineTest < Minitest::Test
  def setup
    data = {
            :items     => "./dummy_data/dummy_items.csv",
            :merchants => "./dummy_data/dummy_merchants.csv"
            #Add CSV dummy files
            }
    @engine = SalesEngine.new(data)
  end

  def test_it_exists
    assert_instance_of SalesEngine, @engine
  end
end
