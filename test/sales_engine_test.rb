require_relative '../lib/sales_engine'
require_relative './test_helper'
require_relative '../lib/merchant_repository'
require_relative '../lib/merchant'
require_relative '../lib/item'
require_relative '../lib/item_repository'

class SalesEngineTest < Minitest::Test
  def test_sales_engine_exists
    se = SalesEngine.from_csv({:items => "./data/items.csv", :merchants => "./data/merchants.csv"
    })
    assert_instance_of SalesEngine, se
  end

  def test_sales_engine_receives_data_from_csv
    se = SalesEngine.from_csv({:items => "./data/items.csv", :merchants => "./data/merchants.csv"
    })

    assert_instance_of MerchantRepository, se.merchants
    assert_instance_of ItemRepository, se.items
  end

  def test_sales_engine_has_sales_analyst
    se = SalesEngine.from_csv({:items => "./data/items.csv", :merchants => "./data/merchants.csv"
    })

    assert_instance_of SalesAnalyst, se.sales_analyst
  end
end
