require 'minitest/autorun'
require 'minitest/pride'
require './lib/sales_engine'

class SalesEngineTest < Minitest::Test
attr_reader :se_hash

  def setup
    @se_hash = {:items => './data/test_items.csv',
            :merchants => './data/test_merchant.csv'}
  end

  def test_an_instance_of_sales_engine_exists
    se = SalesEngine.new(se_hash)
    assert se.instance_of?(SalesEngine)
  end

  def test_items_can_be_retrieved_from_the_hash
    skip
    se = SalesEngine.from_csv(se_hash)
    assert_equal './data/test_items.csv', se.merchants
  end

  def test_from_csv_can_be_call_on_itself
    skip
    se = SalesEngine.from_csv(se_hash)
    merchant = se.merchants
    assert_equal './data/test_items.csv', merchant.all_merchants
  end
end
