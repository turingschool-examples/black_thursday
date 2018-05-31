require './test/test_helper'
require './lib/sales_engine'
require './lib/repository'
require './lib/item_repository'
require './lib/merchant_repository'

class SalesEngineTest < Minitest::Test
  def setup
    @se = SalesEngine.new
  end

  def test_sales_engine_exists
    assert_instance_of SalesEngine, @se
  end

  def test_it_can_return_an_instance_of_item_repository
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
    })
    assert_instance_of ItemRepository, se.items
  end

  def test_it_can_return_an_instance_of_mrechant_repository
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoices  => "./data/invoices.csv"
    })
    assert_instance_of MerchantRepository, se.merchants
  end
end
