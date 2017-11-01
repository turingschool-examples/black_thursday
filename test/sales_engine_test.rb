require_relative 'test_helper'
require_relative '../lib/sales_engine'

class SalesEngineTest < Minitest::Test
  def setup
    files = ({:items => "./test/fixture/items_fixture.csv", :merchants => "./test/fixture/merch_fixture.csv"})
    SalesEngine.from_csv(files)
  end

  def test_it_exists
    assert_instance_of SalesEngine, setup
  end

  def test_item_repo_is_pulled_in
    assert_instance_of ItemRepository, setup.items
  end

  def test_item_repo_is_pulled_in
    assert_instance_of MerchantRepository, setup.merchants
  end

  def test_find_merchant_items_things
    assert_equal 3, setup.find_merchant_items(12334185).count
  end
end
