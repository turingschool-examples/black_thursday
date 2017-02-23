require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/sales_analyst'

class SalesAnalystTest < Minitest::Test
  attr_reader :sa, :se
  def setup
    @se = SalesEngine.from_csv({
      :items     => "./test/fixtures/item_fixture.csv",
      :merchants => "./test/fixtures/merchant_fixture.csv",
    })
    @sa = SalesAnalyst.new(se)
  end

  def test_average_items_per_merchant
    assert_equal 1.88, sa.average_items_per_merchant
  end

  def test_average_items_per_merchant_standard_deviation
    assert_equal 1.88, sa.average_items_per_merchant_standard_deviation
  end

  def test_merchants_with_high_item_count
    assert_equal [4, 12, 4, 5], sa.merchants_with_high_item_count
  end
end
