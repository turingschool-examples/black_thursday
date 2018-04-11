require 'csv'
require './lib/sales_engine'
require_relative '../lib/item_repo'


class SalesEngineTest < Minitest::Test
  attr_reader :se

  def setup
    @se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      })
  end

  def test_it_exists
    
    assert_instance_of SalesEngine, se
  end
end
