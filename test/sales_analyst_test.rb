require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/merchant_repository'
require_relative '../lib/item_repository'
require_relative '../lib/sales_engine'

class SalesAnalystTest < Minitest::Test
  def setup
    se = SalesEngine.from_csv({
            :merchants => './fixtures/merchants_fixtures.csv',
            :items     => './fixtures/items_fixtures.csv'
            })
    @mr = se.merchants
    @sa = SalesAnalyst.new(se)
  end

  def test_average_items_per_merchant_returns_float
    assert_equal  1.75, @sa.average_items_per_merchant
  end

  def test_average_items_per_merchant_standard_deviation
    assert_equal 1.23, @sa.average_items_per_merchant_standard_deviation
  end
end
