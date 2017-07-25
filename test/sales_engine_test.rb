require 'minitest/autorun'
require 'minitest/emoji'
require './lib/sales_engine.rb'
require 'pry'

class SalesEngineTest < Minitest::Test

  def test_it_exists
    se = SalesEngine.from_csv({:items => './data/items.csv',
                               :merchants => './data/merchants.csv'})

    assert_instance_of SalesEngine, se
  end

  def test_it_creates_an_item_repository
    se = SalesEngine.from_csv({:items => './data/items.csv',
                               :merchants => './data/merchants.csv'})

    items = se.items
    assert_instance_of ItemRepository, items
  end

  def test_it_creates_a_merchant_repository
    se = SalesEngine.from_csv({:items => './data/items.csv',
                               :merchants => './data/merchants.csv'})

    merchants = se.merchants
    assert_instance_of MerchantRepository, merchants
  end

  def test_merchant_repository_can_find_all_merchants
    se = SalesEngine.from_csv({:items => './data/items.csv',
                               :merchants => './data/merchants.csv'})

    mr = se.merchants
    merchant = mr.all

    assert_equal 475, merchant.length
    assert_equal Array, merchant.class
  end

  def test_item_repository_can_find_all_items
    se = SalesEngine.from_csv({:items => './data/items.csv',
                               :merchants => './data/merchants.csv'})

    ir = se.items
    item = ir.all

    assert_equal 1367, item.length
    assert_equal Array, item.class
  end

  def test_relationship_layer
    se = SalesEngine.from_csv({:items => './data/items.csv',
                               :merchants => './data/merchants.csv'})

    merchant = se.merchants.find_by_id(12334105)
    binding.pry
    assert_equal [], merchant.items
  end
end