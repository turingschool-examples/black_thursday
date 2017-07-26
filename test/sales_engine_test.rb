gem 'minitest', '~> 5.2'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/sales_engine'
require './lib/merchant_repository'
<<<<<<< HEAD
# require './lib/item_repository'
=======
require './lib/item_repository'
>>>>>>> 4ce2731ed80078c466c4320f16daad0cf92e56a3

- merchants: returns instance of MerchantRepository with all instances loaded
mr = se.merchants
merchant = mr.find_by_name("CJsDecor")

class SalesEngineTest <Minitest::Test
  def test_initialize
    salesengine = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
    })

    assert_instance_of SalesEngine, salesengine
    assert_instance_of ItemRepository, salesengine.items
    assert_instance_of MerchantRepository, salesengine.merchants
  end

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
