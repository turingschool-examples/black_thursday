require_relative 'test_helper'
require_relative '../lib/sales_analyst'
require_relative '../lib/sales_engine'
require_relative '../lib/merchant_repo'
require_relative '../lib/item_repo'

class SalesAnalystTest < Minitest::Test
  attr_reader :sa
  def set_up
    files = ({:items => "./test/fixtures/item_fixture.csv", :merchants => "./test/fixtures/merchant_fixture.csv"})
    se = SalesEngine.from_csv(files)
    @sa = SalesAnalyst.new(se)
  end

  def test_it_exists
    set_up

    assert_instance_of SalesAnalyst, sa
  end

  def test_average_items_per_merchant
    set_up

    assert_equal 0.83, sa.average_items_per_merchant
  end

  def test_find_averages
    set_up

    assert_equal 6, sa.find_averages.count
  end

  def test_standard_deviation
    files = ({:items => "./data/items.csv", :merchants => "./data/merchants.csv"})
    se = SalesEngine.from_csv(files)
    sales_a = SalesAnalyst.new(se)

    assert_equal 3.26, sales_a.average_items_per_merchant_standard_deviation
  end

end
