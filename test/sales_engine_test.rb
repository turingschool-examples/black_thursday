require_relative 'test_helper'
require_relative '../lib/sales_engine.rb'

class SalesEngineTest < MiniTest::Test
  def setup
    @sales_engine = SalesEngine.new("./data/merchants.csv", "./data/items.csv")
  end

  def test_it_exists
    assert_instance_of SalesEngine, @sales_engine
  end

  def test_case_name

  end
end
