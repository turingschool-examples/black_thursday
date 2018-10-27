require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require 'minitest/pride'
require './lib/sales_engine'

class SalesEngineTest < Minitest::Test

  def test_it_exists
    se = SalesEngine.from_csv({
      :items => "./data/items.csv",
      :merchants => "./data/merchants.csv"
      })

    assert_instance_of SalesEngine, se
  end

  def test_it_has_repositories
    se = SalesEngine.from_csv({
      :items => "./data/items.csv",
      :merchants => "./data/merchants.csv"
      })
      ir = se.items
      mr = se.merchants

      assert_instance_of MerchantRepository, mr
      assert_instance_of ItemRepository, ir
  end
end
