require './test/test_helper'

class SalesEngineTest < Minitest::Test

  attr_reader :se

  def setup
    @se = SalesEngine.from_csv({:items     => "./test/fixtures/items_match_merchant_id.csv",
                                :merchants => "./test/fixtures/merchants_test_data.csv"})
  end

  def test_it_exists
    assert_kind_of SalesEngine, SalesEngine.new
  end

  def test_from_csv_returns_sales_engine
    assert_kind_of SalesEngine, se
  end

  def test_merchant_variables_are_populated
    assert_instance_of MerchantRepository, se.merchants
  end

  def test_items_variables_are_populated
   assert_instance_of ItemRepository, se.items
  end
end
