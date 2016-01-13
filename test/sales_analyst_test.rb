require 'minitest/autorun'
require 'minitest/pride'
require './lib/sales_analyst'

class SalesAnalystTest < Minitest::Test
  attr_reader :se_hash, :se, :sa

  def setup
    @se_hash = {:items => './data/test_items.csv',
            :merchants => './data/test_merchant.csv'}
    @se = SalesEngine.new(se_hash)
    @sa = SalesAnalyst.new(se)
  end

  def test_for_instance_of_sales_analyst
    assert sa.instance_of?(SalesAnalyst)
  end

  def test_total_merchants_returns_count_of_all_merchants
    assert_equal 5, sa.total_merchants
  end

  def test_total_items_returns_count_of_all_items
    assert_equal 5, sa.total_items
  end

  def test_average_items_per_merchant
    assert_equal 1, sa.average_items_per_merchant
  end
end
