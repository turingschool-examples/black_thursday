require_relative 'test_helper'
require_relative '../lib/sales_engine'

class SalesEngineTest < Minitest::Test

  def test_it_returns_repositories
    se = SalesEngine.from_csv({
                              :items      => './data/items.csv',
                              :merchants  => './data/merchants.csv'
                              })
    assert_instance_of ItemRepository, se.items
    assert_instance_of MerchantRepository, se.merchants
    assert_instance_of SalesEngine, se
  end
end
