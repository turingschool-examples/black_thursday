require 'minitest/autorun'
require 'minitest/pride'
require './lib/sales_analyst'
require './lib/sales_engine'

class TestSalesAnalyst < MiniTest::Test

  def setup
    @sales_engine = SalesEngine.from_csv({
      items:      "./data/items.csv",
      merchants:  "./data/merchants.csv",
      invoices:   "./data/invoices.csv"
      })
    @sales_analyst = SalesAnalyst.new(@sales_engine)
  end

  def test_it_exists
    assert_instance_of SalesAnalyst, @sales_analyst
  end

  def test_it_finds_average_items_per_merchant
    assert_equal 2.88, @sales_analyst.average_items_per_merchant
    assert_instance_of Float, @sales_analyst.average_items_per_merchant
  end

  def test_it_item_count_of_all_merchants
    assert_equal 475, @sales_analyst.all_merchant_item_count.length
  end
end