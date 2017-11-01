require_relative './test_helper'
require './lib/sales_analyst'

class SalesAnalystTest < Minitest::Test
  attr_reader :se,
              :sa

  def setup
    @se = SalesEngine.from_csv({
      :items => "./test/fixture/item_truncated.csv",
      :merchants => './test/fixture/merchants_truncated.csv',
      :invoices => './test/fixture/invoice_truncated.csv'}
    )
    @sa = SalesAnalyst.new(se)
  end

  def test_initialize_sales_analyst
    assert_instance_of SalesAnalyst, sa
  end

  def test_it_can_determine_average_items_per_merchant
    assert_equal 1, sa.average_items_per_merchant
  end

  def test_it_can_determine_standard_deviation_items_per_merchant
    
    assert_equal 1.0, sa.average_items_per_merchant_standard_deviation
  end

  def test_count_all_items_for_each_merchant
    assert_equal [0,0,0,0,2], sa.count_all_items_for_each_merchant
  end
end
