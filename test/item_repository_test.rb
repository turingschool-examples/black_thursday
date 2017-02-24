require './test/test_helper'
require './lib/item_repository'
require './lib/sales_engine'

class ItemRepositoryTest < Minitest::Test

  def test_it_exists
    se = SalesEngine.from_csv({:items => "./data/items.csv"})
    # se.merchant_repo is an instance of MerchantRepo class!
    assert_instance_of ItemRepository, se.items
  end

end
