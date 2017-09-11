require './test/test_helper'
require './lib/sales_engine'

class SalesEngineTest < Minitest::Test

  def test_from_csv_returns_a_sales_engine
    assert_instance_of SalesEngine, SalesEngine.from_csv({})
  end

  def test_it_can_have_an_items_repository
    se = SalesEngine.from_csv items: "./data/items.csv"
    assert_instance_of ItemsRepository, se.items
  end

  def test_it_can_have_a_merchants_repository
    se = SalesEngine.from_csv merchant: "./data/merchant.csv"
    assert_instance_of MerchantRepository, se.merchant
  end

  def test_it_can_have_multiple_repositories
    se = SalesEngine.from_csv({
      items: "./data/items.csv",
      merchant: "./data/merchant.csv"
    })
    assert_instance_of ItemsRepository, se.items
    assert_instance_of MerchantRepository, se.merchant
  end

end
