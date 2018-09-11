require_relative './test_helper'
require_relative '../lib/sales_analyst'
require_relative '../lib/sales_engine'

class SalesAnalystTest < Minitest::Test
  def setup
    @engine = SalesEngine.from_csv({:items => "./test/data/items.csv",
                                    :merchants => "./test/data/merchants.csv"})

    @analyst = @engine.analyst
  end

  def test_it_exists
    assert_instance_of SalesAnalyst, @analyst
  end

  def test_it_has_an_engine
    assert_instance_of SalesEngine, @analyst.engine
  end

  def test_it_can_return_average_items_per_merchant
    actual = @analyst.average_items_per_merchant
    assert_instance_of Float, actual
    assert_equal 0.11, actual
  end

  def test_it_can_return_average_items_per_merchant_standard_deviation
    merch = stub("Merchant", id:1)
    merch_array = [merch, merch, merch, merch, merch]
    @engine.merchants.stubs(:all).returns(merch_array)
    @engine.items.stubs(:find_all_by_merchant_id).returns([0]*5, [0]*3,
                                                          [0]*6, [0]*2,
                                                          [0]*7)

    actual = @analyst.average_items_per_merchant_standard_deviation
    assert_equal 2.07, actual
  end
end
