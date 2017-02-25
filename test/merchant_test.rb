require "minitest/autorun"
require "minitest/pride"
require "./lib/merchant"
require "./lib/sales_engine"
require './lib/merchant_repository'
require "simplecov"
SimpleCov.start

require 'pry'

class MerchantTest < Minitest::Test

  def test_it_exists
    se = SalesEngine.from_csv({:merchants => './test/fixtures/merchants_three.csv'})
    mr = se.merchants
    m = mr.all
    
    assert_instance_of Merchant, m.first
  end

  def test_id_method_returns_id
    se = SalesEngine.from_csv({:merchants => './test/fixtures/merchants_three.csv'})
    mr = se.merchants
    m = mr.all
    
    assert_equal 12334105, m.first.id
  end

  def test_name_method_returns_name
    se = SalesEngine.from_csv({:merchants => './test/fixtures/merchants_three.csv'})
    mr = se.merchants
    m = mr.all
    
    assert_equal "Shopin1901", m.first.name
  end

  def test_parent_is_instance_of_merchant_repository
    se = SalesEngine.from_csv({:merchants => './test/fixtures/merchants_three.csv'})
    mr = se.merchants
    m = mr.all

    assert_instance_of MerchantRepository, m.first.parent
  end

  def test_merchant_can_find_items
    se = SalesEngine.from_csv({:merchants => './test/fixtures/merchant_matches.csv', :items => './test/fixtures/items_same_merchant_id.csv'})
    merchant = se.merchants.find_by_id(12334185)   
    
    assert_equal Array, merchant.items.class
    assert_equal 3, merchant.items.length
    assert_equal Item, merchant.items.first.class
  end
end

