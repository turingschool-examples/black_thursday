require "minitest/autorun"
require "./lib/sales_engine"


class SalesEngineTest < Minitest::Test

  def test_it_loads_items_csv
    se = SalesEngine.from_csv({:items     => "./data/items.csv",
                               :merchants => "./data/merchants.csv"})
    mr = se.merchants
    merchant = mr.find_by_name("CJsDecor")
    assert_kind_of Merchant, merchant
    # assert se.items.include?("id,name,description")
  end

  def test_it_loads_merchants_csv
    skip
    se = SalesEngine.new
    assert se
    puts se.merchants.inspect
    # assert se.merchants.include?("id,name,created_at,updated_at")
  end
end
