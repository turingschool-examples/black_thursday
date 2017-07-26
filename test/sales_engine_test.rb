<<<<<<< HEAD
se = SalesEngine.from_csv({
  :items     => "./data/items.csv",
  :merchants => "./data/merchants.csv",
})
- items: returns instance of ItemRepository with all instances loaded
ir   = se.items
item = ir.find_by_name("Item Repellat Dolorum")
=======
gem 'minitest', '~> 5.2'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/sales_engine'
require './lib/merchant_repository'
# require './lib/item_repository'
>>>>>>> 2d200b0a046704c334a61ada479e4cc45cfb1a60

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
