require 'minitest/autorun'
require 'minitest/pride'
require './lib/sales_engine'
require './lib/merchant_repository'
require './lib/item_repository'

class SalesEngineTest < Minitest::Test

  def test_sales_engine_exists
    assert SalesEngine.new
  end

  def test_merchant_returns_a_merchant_object
    sales_engine = SalesEngine.from_csv({
      :items => "./data_fixtures/items_fixture.csv",
      :merchants => "./data_fixtures/merchants_fixture.csv"
    })
    assert_kind_of MerchantRepository, sales_engine.merchants
  end

  def test_item_returns_an_item_object
    sales_engine = SalesEngine.from_csv({
      :items => "./data_fixtures/items_fixture.csv",
      :merchants => "./data_fixtures/merchants_fixture.csv"
    })
    assert_kind_of ItemRepository, sales_engine.items
  end

end