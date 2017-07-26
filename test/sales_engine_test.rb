gem 'minitest', '~> 5.2'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/sales_engine'
require './lib/merchant_repository'
require './lib/item_repository'

class SalesEngineTest < Minitest::Test

  def test_sales_engine_exists
    se = SalesEngine.from_csv({
          :items     => "./data/items.csv",
          :merchants => "./data/merchants.csv",
        })

    assert_instance_of SalesEngine, se
  end

  def test_sales_engine_initializes_with_merchant_repository
    se = SalesEngine.from_csv({
          :items     => "./data/items.csv",
          :merchants => "./data/merchants.csv",
        })

    assert_instance_of MerchantRepository, se.merchants
  end

end
