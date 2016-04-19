require './test/test_helper'
require './lib/sales_engine'


class SalesEngineTest < Minitest::Test
  def test_sales_engine_from_csv
    se = SalesEngine.from_csv({
      :items     => "./data/small_items.csv",
      :merchants => "./data/small_merchants.csv",})

    assert ItemRepository, se.items
    assert MerchantRepository, se.merchants
    # classes or instance variables?
  end
end
