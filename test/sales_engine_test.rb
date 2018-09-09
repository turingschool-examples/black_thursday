require_relative './test_helper'
require_relative '../lib/sales_engine'


class SalesEngineTest < Minitest::Test
  def setup
    SalesEngine.stubs(:hash_from_csv).returns("data")
    @se = SalesEngine.from_csv({:items => "./data/items.csv",
                                :merchants => "./data/merchants.csv"})
  end

  def test_it_exists_and_is_initialized_from_csv_hash
    assert_instance_of SalesEngine, @se
  end

  def test_it_has_item_and_merchant_repositories
    assert_instance_of ItemRepository, @se.items
    assert_instance_of MerchantRepository, @se.merchants
  end
end
