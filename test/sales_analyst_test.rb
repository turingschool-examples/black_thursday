require './test/test_helper'
require './lib/sales_analyst'
require './lib/sales_engine'

class SalesAnalystTest < Minitest::Test

  def setup
    @se = SalesEngine.from_csv({
      :items     => './data/items.csv',
      :merchants => './data/merchants.csv',
      })

    @sa = SalesAnalyst.new(@se)
  end

  def test_it_can_find_total_number_of_merchants
    assert_equal 475, @se.total_merchants
  end

  def test_it_can_find_total_number_of_items
    assert_equal 1603, @se.total_items
  end

  def test_it_can_find_the_average_number_of_items_per_merchant
    assert_equal 2.88, @sa.average_items_per_merchant
  end
end
