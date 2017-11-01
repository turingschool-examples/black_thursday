require_relative 'test_helper'
require_relative '../lib/sales_analyst'
require_relative '../lib/sales_engine'

class SalesAnalystTest < Minitest::Test
  attr_reader :sa, :se
  def setup
    files = ({:items => "./data/items.csv", :merchants => "./data/merchants.csv"})
    @se = SalesEngine.from_csv(files)
    @sa = SalesAnalyst.new(se)
  end

  def test_it_exists
    assert_instance_of SalesAnalyst, setup
  end

  def test_it_averages_items_per_merchant
    assert_equal 2.88, setup.average_items_per_merchant
  end

  def test_item_count_for_merchants
    assert_equal 475, setup.counts_per_merchant(se.method(:find_merchant_items)).count
  end

  def test_item_count_for_merchants_from_fixture
    files = ({:items => "./data/items.csv", :merchants => "./data/merchants.csv"})
    @se = SalesEngine.from_csv(files)
    @sa = SalesAnalyst.new(se)

    assert_equal 3, setup.merch_id.counts_per_merchant(se.method(:find_merchant_items)).count
  end
end
