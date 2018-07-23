require_relative 'test_helper'
require_relative '../lib/sales_engine'

class SalesEngineTest < Minitest::Test
  def test_it_exists
    items = "./data/items.csv"
    merchants = "./data/merchants.csv"
    sales_engine = SalesEngine.new(items, merchants)

    assert_instance_of SalesEngine, sales_engine
  end

  def test_factory_method_creates_instance
    sales_engine = SalesEngine.from_csv({
          :items     => "./data/items.csv",
          :merchants => "./data/merchants.csv",
          })

    assert_instance_of SalesEngine, sales_engine
  end

  def test_it_creates_merchant_repository_object
    sales_engine = SalesEngine.from_csv({
          :items     => "./data/items.csv",
          :merchants => "./data/merchants.csv",
          })

    assert_instance_of MerchantRepository, sales_engine.merchants
  end

  def test_it_creates_item_repository_object
    sales_engine = SalesEngine.from_csv({
          :items     => "./data/items.csv",
          :merchants => "./data/merchants.csv",
          })

    assert_instance_of ItemRepository, sales_engine.items
  end

  def test_it_creates_new_sales_analyst
    sales_engine = SalesEngine.from_csv({
          :items     => "./data/items.csv",
          :merchants => "./data/merchants.csv",
          })
    sales_analyst = sales_engine.analyst

    assert_instance_of SalesAnalyst, sales_analyst
  end
end
