require './test/test_helper.rb'
require './lib/sales_analyst'
require './lib/sales_engine'

class SalesAnalystTest < MiniTest::Test
  def setup
    se = SalesEngine.new({
      items:     './test/fixtures/items_truncated.csv',
      merchants: './test/fixtures/merchants_truncated.csv'
    })
    @sa = SalesAnalyst.new(se)
  end

  def test_it_finds_average_items_per_merchant
    assert_equal 1, @sa.average_items_per_merchant
  end
end
