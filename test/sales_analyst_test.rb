require_relative 'test_helper'
require_relative '../lib/sales_analyst.rb'
require_relative '../lib/sales_engine.rb'

class SalesAnalystTest < Minitest::Test
  def setup
    @sales_engine = SalesEngine.from_csv({
                        :items     => "./data/items.csv",
                        :merchants => "./data/merchants.csv",
                      })
    @sales_analyst = @sales_engine.analyst
  end

  def test_it_exists
    assert_instance_of SalesAnalyst, @sales_analyst
  end
end
