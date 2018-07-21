require_relative 'test_helper'
require_relative '../lib/sales_engine.rb'

class SalesEngineTest < MiniTest::Test
  def setup
    @sales_engine_csv = SalesEngine.from_csv({
                        :items     => "./data/items.csv",
                        :merchants => "./data/merchants.csv",
                      })
    @sales_engine = SalesEngine.new("./data/merchants.csv", "./data/items.csv")

  end

  def test_it_exists
    assert_instance_of SalesEngine, @sales_engine
  end
  def test_it_returns_merchants
    assert_equal merchants, @sales_engine.merchants
  end
  we did it

end
