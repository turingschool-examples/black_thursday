require './test/test_helper'
require './lib/sales_analyst'
require './lib/sales_engine'

class SalesAnalystTest < Minitest::Test
  attr_reader :sa

  def setup
    se = SalesEngine.from_csv({
      :items     => "./test/fixtures/items_fixture.csv",
      :merchants => "./test/fixtures/merchants_fixture.csv",
    })
    @sa = SalesAnalyst.new(se)
  end

  def test_has_sales_engine
    assert_instance_of SalesEngine, sa.engine
  end

  def test_method_average_items_per_merchant_returns_float
    mock_se = Minitest::Mock.new
    sa = SalesAnalyst.new(mock_se)

    mock_se.expect(:items_by_merchant,[3,4,5], [])
    mock_se.expect(:total_merchants, 3, [])
    assert_equal 4.0, sa.average_items_per_merchant

    mock_se.expect(:items_by_merchant,[10,20,30,40,50], [])
    mock_se.expect(:total_merchants, 5, [])
    assert_equal 30.0, sa.average_items_per_merchant
  end

end
