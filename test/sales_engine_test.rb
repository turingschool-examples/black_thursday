require './test/test_helper'
require './lib/sales_engine'
require './lib/items_repository'
require './lib/merchant_repo'

class SalesEngineTest < Minitest::Test
  def test_can_add_both
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
    })

    assert_instance_of ItemsRepository, se.items
    assert_instance_of MerchantRepo, se.merchants
  end

end
