require_relative 'test_helper'
require_relative '../lib/sales_engine'

class SalesEngineTest < Minitest::Test

  attr_reader :sales_engine

  def setup
    @sales_engine = SalesEngine.from_csv({
      :items => "./test/data_fixtures/items_fixture.csv",
      :merchants => "./test/data_fixtures/merchants_fixture.csv"
    })
  end
  
  def test_sales_engine_exists
    assert sales_engine
  end

  def test_merchant_returns_a_merchant_repository_object
    assert_kind_of MerchantRepository, sales_engine.merchants
  end

  def test_item_returns_an_item_repository_object
    assert_kind_of ItemRepository, sales_engine.items
  end

end