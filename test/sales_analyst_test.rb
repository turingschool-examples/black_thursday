require_relative 'test_helper'
require_relative '../lib/sales_analyst'
require_relative '../lib/sales_engine'

class SalesAnalystTest < Minitest::Test

  attr_reader :merch_repo, :se, :sa

  def setup
    @se = SalesEngine.from_csv({
      :items     => "./data/small_items.csv",
      :merchants => "./data/small_merchants.csv",})
    @sa = SalesAnalyst.new(se)
    @se.merchants
    @se.items
    @merch_repo = @se.merchant_repo
  end

  def test_average_items_per_merchant_gives_correct_average
    assert_equal 1.90, sa.average_items_per_merchant
  end
end
