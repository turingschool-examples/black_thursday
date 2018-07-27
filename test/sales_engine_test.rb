require_relative "./test_helper"
require_relative "../lib/sales_engine"
require_relative "../lib/merchant_repo"
require_relative "../lib/item_repo"
require_relative "../lib/merchant"
require_relative "../lib/item"

class SalesEngineTest < Minitest::Test

  def test_it_exists
    sales_engine = SalesEngine.from_csv({:items => "./data/items.csv", :merchants => "./data/merchants.csv"})
    assert_instance_of SalesEngine, sales_engine
  end

  # def test_it_loads_from_csv
  #   actual = SalesEngine.from_csv({ #:items     => "./data/items.csv",
  #                                   :merchants => "./data/merchants.csv"})
  #   assert_instance_of SalesEngine, actual
  # end
end
