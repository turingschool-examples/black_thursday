require './test/test_helper'
require './lib/sales_engine'
require 'pry'

class SalesEngineTest < Minitest::Test

  def setup
    @salesengine = SalesEngine.from_csv({ :items         => "./data/items.csv",
                                    :merchants     => "./data/merchants.csv",
                                    })
  end

  def test_it_exists_with_repos
    assert_instance_of SalesEngine, @salesengine
    assert_instance_of ItemRepository, @salesengine.items
    assert_instance_of MerchantRepository, @salesengine.merchants
  end

  def test_engine_repos_have_instances
    assert_instance_of Item, @salesengine.items.items[263395237]
    assert_instance_of Merchant, @salesengine.merchants.merchants[12334105]
  end

  def test_engine_can_find_items_by_merchant_id
    items = @salesengine.find_items_by_merchant_id(12334105)

    assert_instance_of Array, items
    assert_instance_of Item, items[0]
  end

  def test_it_can_find_merchant_by_id
    merchant = @salesengine.find_merchant_by_id(12334105)

    assert_instance_of Merchant, merchant
  end

end
