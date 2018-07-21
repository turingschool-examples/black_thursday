require_relative "test_helper.rb"
require_relative "../lib/sales_engine"

class SalesEngineTest < Minitest::Test

  def test_it_exists
    csv_hash = {
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
    }
    se = SalesEngine.from_csv(csv_hash)

    assert_instance_of SalesEngine, se
  end
end
