require './test/test_helper'
require './lib/sales_engine'

class SalesAnalystTest < Minitest::Test

  def setup
    sales_engine = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
    })
    @sa = sales_engine.analyst
  end

  def test_average_items_per_merchant

    assert_equal 2.88 , @sa.average_items_per_merchant

  end
end
