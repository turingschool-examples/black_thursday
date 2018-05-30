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
      :items => "./data/item_sample.csv",
      :merchants => "./data/merchant_sample.csv"
    })

    sales_analyst = sales_engine.analyst

    assert_instance_of SalesAnalyst, sales_analyst
  end
end
