require "./test/test_helper"
require "./lib/sales_engine"
require "./lib/sales_analyst"
# require "./lib/item_repository"
# require "./lib/merchant_repository"
# require "./lib/merchant"
# require "./lib/item"



class TestSalesAnalyst < Minitest::Test

  attr_reader :sa

  def setup
    csv_hash = {
      :items     => "./test/test_data/items_short.csv",
      :merchants => "./test/test_data/merchants_short.csv",
    }
    se = SalesEngine.from_csv(csv_hash)
    @sa = SalesAnalyst.new(se)
  end

  def test_its_exists
    assert_instance_of SalesAnalyst, sa
  end

  def test_it_averages_items_per_merchant
    assert_equal 2.0, sa.average_items_per_merchant
  end

  def test_it_takes_a_standard_deviation
    assert_equal 1.0, sa.average_items_per_merchant_standard_deviation
  end

  def test_it_find_merchants_with_high_item_count
    assert_instance_of Array, sa.merchants_with_high_item_count
    assert_instance_of Merchant, sa.merchants_with_high_item_count[0]
  end



end
