require './lib/sales_analyst'
require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'

class SalesAnalystTest < Minitest::Test
  def setup
    @se = SalesEngine.from_csv({
                              :items     => "./data/items.csv",
                              :merchants => "./data/merchants.csv",
                                                                  })
    @sa = SalesAnalyst.new(@se)
  end

  def test_it_can_be_initialized
    sa = SalesAnalyst.new(SalesEngine.new(0))
    assert_instance_of SalesAnalyst, sa
    assert sa
  end

  def test_it_can_do_average
    assert_equal 2.88, @sa.average_items_per_merchant
  end

  def test_it_can_do_standard_dev
    assert_equal 3.32, @sa.average_items_per_merchant_standard_deviation
  end

  def test_it_can_do_average_item_price_for_merchant
    assert_equal 13000, @sa.average_item_price_for_merchant(12335227)
  end
end
