require './test_helper'
require './lib/merchant'
require './lib/merchant_repository'
require './lib/file_loader'
require './lib/sales_engine'
require 'pry'

class SalesAnalystTest < MiniTest::Test
  include FileLoader

  def test_it_exists
    sales_engine = SalesEngine.from_csv({
      :items => "./data/items.csv",
      :merchants => "./data/merchants.csv"
    })

    sales_analyst = sales_engine.analyst

    assert_instance_of SalesAnalyst, sales_analyst
  end

  def test_it_can_get_average_items_per_merchant
    sales_engine = SalesEngine.from_csv({
      :items => "./data/items.csv",
      :merchants => "./data/merchants.csv"
    })

    sales_analyst = sales_engine.analyst

    assert_equal 2.88, sales_analyst.average_items_per_merchant
  end
end
