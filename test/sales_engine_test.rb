require_relative './test_helper'
require './lib/sales_engine'
require './lib/merchant_repository'
require './lib/item_repository'
require './lib/merchant'
require './lib/item'
require './lib/sales_analyst'


class SalesEngineTest < Minitest::Test

  def setup
    @se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      })
  end

  def test_it_exists_and_has_attributes
    assert_instance_of SalesEngine, @se
    assert_instance_of MerchantRepository, @se.merchants
    assert_instance_of ItemRepository, @se.items
    assert_instance_of SalesAnalyst, @se.analyst
  end
end
