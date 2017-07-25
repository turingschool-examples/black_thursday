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

end