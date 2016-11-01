require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/sales_engine'
require_relative '../lib/merchant_repository'
require_relative '../lib/item_repository'

class SalesEngineTest < Minitest::Test

  def test_sales_engine_exists
    assert SalesEngine.new
  end

  def test_merchant_returns_a_merchant_repository_object
    sales_engine = SalesEngine.from_csv({
      :items => "./data_fixtures/items_fixture.csv",
      :merchants => "./data_fixtures/merchants_fixture.csv"
    })
    assert_kind_of MerchantRepository, sales_engine.merchants
  end

  def test_item_returns_an_item_repository_object
    sales_engine = SalesEngine.from_csv({
      :items => "./data_fixtures/items_fixture.csv",
      :merchants => "./data_fixtures/merchants_fixture.csv"
    })
    assert_kind_of ItemRepository, sales_engine.items
  end

end