require_relative 'test_helper.rb'
require_relative '../lib/sales_engine.rb'

class SalesEngineTest < Minitest::Test

  def test_sales_engine_exists
    engine = SalesEngine.new 

    assert engine 
    assert_instance_of SalesEngine, engine
  end

  def test_sales_engine_loads_merchant_repository
    se = SalesEngine.from_csv({ :items     => "./data/items.csv",
                                :merchants => "./data/merchants.csv"})

    assert_instance_of Merchant, se.merchants.all[0]
    assert_instance_of Merchant, se.merchants.all[-1]
    assert_equal 475, se.merchants.all.length
  end

  def test_sales_engine_loads_item_repository
    se = SalesEngine.from_csv({ :items     => "./data/items.csv",
                                :merchants => "./data/merchants.csv"})

    assert_instance_of Item, se.items.all[0]
    assert_instance_of Item, se.items.all[-1]
    assert_equal 1367, se.items.all.length
  end
end