require './test/test_helper'
require './lib/salesengine'
require 'pry'

class SalesEngineTest < Minitest::Test

  def test_it_exists
    salesengine = SalesEngine.from_csv({ :items         => "./data/items.csv",
                                    :merchants     => "./data/merchants.csv",
                                    })

    assert_instance_of SalesEngine, salesengine
  end

  def test_it_can_create_item_repo
    salesengine = SalesEngine.from_csv({ :items         => "./data/items.csv",
                                    :merchants     => "./data/merchants.csv",
                                    })
    assert_instance_of ItemRepository, salesengine.items
  end

  def test_item_repo_has_item_instances
    salesengine = SalesEngine.from_csv({ :items         => "./data/items.csv",
                                    :merchants     => "./data/merchants.csv",
                                    })

    assert_instance_of Item, salesengine.items.contents["263395237"]
  end

  def test_it_can_create_merchant_repo
    salesengine = SalesEngine.from_csv({ :items         => "./data/items.csv",
                                    :merchants     => "./data/merchants.csv",
                                    })
    assert_instance_of MerchantRepository, salesengine.merchants
  end

  def test_merchant_repo_has_merchant_instances
    salesengine = SalesEngine.from_csv({ :items         => "./data/items.csv",
                                    :merchants     => "./data/merchants.csv",
                                    })

    assert_instance_of Merchant, salesengine.merchants.contents["12334105"]
  end

end
