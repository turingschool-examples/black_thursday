require './test/test_helper'
require './lib/sales_engine'
require './lib/items_repository'
require './lib/merchant_repo'

class SalesEngineTest < Minitest::Test

  # def test_exists
  #   se = SalesEngine.new
  #   assert_instance_of SalesEngine, se
  # end

  # def test_can_add_items
  #   se = SalesEngine.new
  #   se.from_csv({
  #     :items => "./data/items.csv"
  #   })
  #   assert_instance_of ItemsRepository, se.items
  # end

  # def test_can_add_merchants
  #   se = SalesEngine.new
  #   se.from_csv({
  #     :merchants => "./data/merchants.csv"
  #   })
  #   assert_instance_of MerchantRepo, se.merchants
  # end

  def test_can_add_both
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
    })

    assert_instance_of ItemsRepository, se.items
    assert_instance_of MerchantRepo, se.merchants
  end

end