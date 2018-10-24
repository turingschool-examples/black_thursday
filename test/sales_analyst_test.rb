require './test/test_helper'

class SalesAnalystTest < Minitest::Test
  def setup
    sales_engine = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
    })
    @sa = sales_engine.analyst
  end

  def test_average_items_per_merchant
    

  end
end
