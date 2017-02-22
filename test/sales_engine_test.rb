require "minitest/autorun"
require "minitest/pride"
require "./lib/sales_engine"
require "simplecov"
SimpleCov.start

class SalesEngineTest < Minitest::Test
  def test_it_exists
    se = SalesEngine.new
    assert_instance_of SalesEngine, se
  end

  def test_it_takes_hash_argument
    se = SaleEngine.from_csv({:merchants => './test/fixtures/merchants_one.csv'})
    
  end

end


