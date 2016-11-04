require_relative 'test_helper'
require './lib/sales_analyst.rb'

class SalesAnalystTest < Minitest::Test

  def setup
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
    })
    @sa = SalesAnalyst.new(se)
  end

  def test_it_exists
  assert @sa
  end

  def test_it_can_find_the_standard_deviation
    result = @sa.average_items_per_merchant_standard_deviation
  end
end