require_relative './helper'
require_relative '../lib/sales_engine'
require_relative '../lib/merchant'
require_relative '../lib/merchant_repository'
require_relative '../lib/item_repository'
require_relative '../lib/item'
class SalesEngineTest < Minitest::Test
  def test_it_exists
    se = SalesEngine.from_csv( {
        :items      => "./data/items.csv",
        :merchants  => "./data/merchants.csv"
                             } )
    assert_instance_of SalesEngine, se
    # assert_instance_of ItemRepository, se.items
    # assert_instance_of MerchantRepository, se.merchants
  end

end
