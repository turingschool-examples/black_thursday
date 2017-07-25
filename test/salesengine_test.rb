require_relative 'test_helper'
require './lib/salesengine'


class SalesEngineTest < Minitest::Test

  def test_it_exist
    salesengine = SalesEngine.new({ :items     => "./data/items.csv",
                                    :merchants => "./data/merchants.csv",})

    assert_instance_of SalesEngine, salesengine
  end

  def test_it_items_returns_new_instance_of_item_repo
    salesengine = SalesEngine.new({ :items     => "./data/items.csv",
                                    :merchants => "./data/merchants.csv",})

    assert_instance_of ItemRepository, salesengine.items
  end

  def test_its_merchants_returns_new_instance_of_merchant_repo
    salesengine = SalesEngine.new({ :items     => "./data/items.csv",
                                    :merchants => "./data/merchants.csv",})


    assert_instance_of MerchantRepository, salesengine.merchants
  end


end
