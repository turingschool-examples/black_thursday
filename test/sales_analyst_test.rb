require_relative './test_helper'

class SalesAnalystTest < Minitest::Test

  def setup
    @sales_engine = SalesEngine.from_csv({
    :items     => "./data/items.csv",
    :merchants => "./data/merchants.csv",
    })
  end

  def test_it_exists
    sales_analyst = SalesAnalyst.new
    assert_instance_of SalesAnalyst, sales_analyst
  end

  def test_it_can_be_created_by_sales_engine
      sales_analyst = @sales_engine.analyst
      assert_instance_of SalesAnalyst, sales_analyst
  end

  def test_analyst_can_find_who_sells_the_most
    skip

  end

  def test_it_can_average_price_of_items_by_merchant
    sa = @sales_engine.analyst
    average = sa.average_item_price_for_merchant(12334185)

    assert_equal 0, average
  end
end
