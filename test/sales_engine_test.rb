require_relative "test_helper.rb"
require_relative "../lib/sales_engine"

class SalesEngineTest < Minitest::Test
  def test_it_exists
    content = {
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
    }

    sales_engine = SalesEngine.new(content)
    assert_instance_of SalesEngine, sales_engine
  end

end
