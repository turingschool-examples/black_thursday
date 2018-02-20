require_relative 'test_helper.rb'
require_relative '../lib/sales_analyst.rb'
require_relative '../lib/sales_engine.rb'

class SalesAnalystTest < Minitest::Test

  def setup
    @sales_engine = SalesEngine.from_csv({
      items: './data/items.csv',
      merchants: './data/merchants.csv'
      })

    @sales_analyst = SalesAnalyst.new(@sales_engine)
  end
  def test_analyst_initializes
    assert_instance_of SalesAnalyst, @sales_analyst
  end

  def test_can_return_average_items_per_merchant
    result = @sales_analyst.average_items_per_merchant

    assert_equal 2.88, result
  end
end
