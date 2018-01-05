require "./test/test_helper"
require "./lib/sales_analyst"
require "./lib/sales_engine"

class SalesAnalystTest < MiniTest::Test

  def test_it_exists
    sales = "sales"
    sales_analyst = SalesAnalyst.new(sales)
    assert_instance_of SalesAnalyst, sales_analyst
  end

  def test_item_counter_returns_amount_of_items
    skip
    items = stub(find_all_by_merchant_id: ["<Item>", "<Item>"])
    sales_engine = stub(items: items)
    sales_analyst = SalesAnalyst.new(sales_engine)
    assert_equal 0, sales_analyst.item_counter
  end


end
