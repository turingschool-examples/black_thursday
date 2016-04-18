require 'minitest/autorun'
require 'minitest/pride'
require './lib/sales_engine.rb'

class SalesEngineTest < MiniTest::Test
   attr_reader :se

  def setup
    @se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
    })
  end

  def test_it_creates_instance
    assert se
  end

  def test_it_finds_merchant_method
    assert_equal "./data/merchants.csv", se.merchants
  end
  #
  # undefined method `merchants' for "./data/merchants.csv":String
  #   test/sales_engine_test.rb:20:in `test_it_finds_merchant_method'

end
