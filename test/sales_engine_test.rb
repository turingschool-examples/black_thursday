require 'csv'
require './lib/sales_engine'

class SalesEngineTest < Minitest::Test
  attr_reader :se

  def setup
    @se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      })
  end

  def test_it_exists
    skip
    assert_instance_of SalesEngine, se
  end
end
