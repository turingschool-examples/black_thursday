require './test/test_helper'
require './lib/sales_engine'

class SalesEngineTest < Minitest::Test
  def test_sales_engine_exists
    se = SalesEngine.from_csv({:merchants => "./data/merchants.csv"})
    assert_instance_of SalesEngine, se
  end

  def test_se_merchant_method_reads_merchant_file
    se = SalesEngine.from_csv({:merchants => "./data/merchants.csv"})
    assert_instance_of MerchantRepository, se.merchants
  end

  def test_se_merchant_method_reads_items_file
    skip
    se = SalesEngine.from_csv({:items => "./data/items.csv"})
    assert_instance_of ItemRepository, se.items
  end

end
