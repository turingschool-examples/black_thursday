require './test/test_helper'
require './lib/sales_engine'
require './lib/repository'
require './lib/item_repository'
require './lib/merchant_repository'

class SalesEngineTest < Minitest::Test
  def setup
    paths = {
    :items                => "./data/items.csv",
    :merchants            => "./data/merchants.csv",
    :invoices             
  }
    @se = SalesEngine.from_csv(paths)
  end

  def test_sales_engine_exists
    binding.pry
    assert_instance_of SalesEngine, @se
  end

  # def test_it_can_return_an_instance_of_item_repository
  #   skip
  #     @se.from_csv({
  #     :items     => "./data/items.csv",
  #     :merchants => "./data/merchants.csv",
  #   })
  #   assert_instance_of ItemRepository, se.items
  #   binding.pry
  # end
  #
  # def test_it_can_return_an_instance_of_mrechant_repository
  #   skip
  #   se = SalesEngine.from_csv({
  #     :items     => "./data/items.csv",
  #     :merchants => "./data/merchants.csv",
  #     :invoices  => "./data/invoices.csv"
  #   })
  #   assert_instance_of MerchantRepository, se.merchants
  # end
end
