require_relative 'test_helper'
require_relative '../lib/sales_analyst'
require 'pry'

class SalesAnalystTest < Minitest::Test

  def setup
    item_path      = "./test/fixture_data/item_sa.csv"
    merchant_path  = "./test/fixture_data/merchant_sa.csv"
    path           = {item_data: item_path, merchant_data: merchant_path}
    sales_engine  = SalesEngine.from_csv(path)
    @sales_analyst = sales_engine.analyst
    @items_per_merchant = @sales_analyst.items_per_merchant
    @average = @sales_analyst.average_items_per_merchant
  end

  def test_it_exists
    assert_instance_of SalesAnalyst, @sales_analyst
  end
end