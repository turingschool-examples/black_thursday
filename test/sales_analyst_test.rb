require_relative 'test_helper'
require_relative '../lib/sales_analyst'


class SalesAnalystTest < Minitest::Test

  attr_reader :sales_analyst

  def setup
    @se = SalesEngine.new({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
    })
    @sales_analyst = SalesAnalyst.new(@se)
  end

  def test_it_exists
    assert_instance_of SalesAnalyst, sales_analyst
  end

  def test_it_returns_average
    assert_equal 2.88, sales_analyst.average_items_per_merchant
  end

end
