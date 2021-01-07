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
end
