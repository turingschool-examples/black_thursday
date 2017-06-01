require 'pry'
require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/sales_engine'

class SalesEngineTest < MiniTest::Test

  def test_from_csv_creates_an_instance_of_sales_engine
    se = SalesEngine.from_csv({:items => './data/items_test.csv',
                               :merchants => './data/merchants_test.csv'})

    assert_instance_of SalesEngine, se
  end

  def test_merchant_repo_creates
    se = SalesEngine.from_csv({:items => './data/items_test.csv',
                               :merchants => './data/merchants_test.csv'})
    mr = se.merchants

    assert_instance_of MerchantRepository, mr
  end

  def test_items_repo_creates
    se = SalesEngine.from_csv({:items => './data/items_test.csv',
                               :merchants => './data/merchants_test.csv'})
    ir = se.items

    assert_instance_of ItemRepository, ir
  end
end
