require 'minitest/autorun'
require 'minitest/pride'
require 'mocha/minitest'
require './lib/sales_analyst'

class SalesAnalystTest < Minitest::Test
  def test_it_exists
    sales_engine = SalesEngine.from_csv({
                                :items     => "./data/items.csv",
                                :merchants => "./data/merchants.csv",
                                })
    sales_analyst = sales_engine.analyst
    assert_instance_of SalesAnalyst, sales_analyst
  end
end
