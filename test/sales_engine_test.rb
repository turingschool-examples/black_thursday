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
                              # binding.pry
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

  def test_can_retrieve_items_from_items_repo_with_merchant_id
    se = SalesEngine.from_csv({:items => './data/items.csv',
                               :merchants => './data/merchants.csv'})

    target = se.pass_merchant_id(12334105)

    assert_equal 3, target.count
    assert_equal Array, target.class
  end

  def test_it_can_retrieve_items_from_items_with_merchant_id
    se = SalesEngine.from_csv({:items => './data/items.csv',
                               :merchants => './data/merchants.csv'})

    merchant = se.merchants.find_by_id(12334105)

    assert_equal 3, merchant.items.count
    assert_equal Array, merchant.items.class
  end

  def test_it_can_retrieve_merchant_with_merchant_id_from_item
    se = SalesEngine.from_csv({:items => './data/items.csv',
                               :merchants => './data/merchants.csv'})

    item = se.items.find_by_id(263395237)
# binding.pry
    assert_equal "jejum", item.merchant.name
  end



end