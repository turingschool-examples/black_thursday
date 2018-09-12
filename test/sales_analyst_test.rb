require_relative './test_helper'
require_relative '../lib/item'
require_relative '../lib/item_repository'
require_relative '../lib/merchant'
require_relative '../lib/merchant_repository'
require_relative '../lib/sales_engine'
require_relative '../lib/sales_analyst'

class SalesAnalystTest < Minitest::Test
  def test_it_exists
    sales_engine = SalesEngine.from_csv({
        :items => './data/test_items.csv',
        :merchants => './data/test_merchants.csv'
    })
    sales_analyst = sales_engine.analyst

    assert_instance_of SalesAnalyst, sales_analyst
  end

  def test_it_can_calculate_average_items_per_merchant
    sales_engine = SalesEngine.from_csv({
        :items => './data/items.csv',
        :merchants => './data/merchants.csv'
    })
    sales_analyst = sales_engine.analyst

    assert_equal 2.88, sales_analyst.average_items_per_merchant
  end

end
