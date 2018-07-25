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

  def test_it_exists
    # skip
    assert_instance_of SalesAnalyst, @sa
  end

  def test_it_can_create_an_instance_of_sales_engine
    # skip
    assert_instance_of SalesEngine, @sa.se
  end

  def test_it_can_group_items_by_merchant
    # skip
    assert_equal 2, @sa.group_items_by_merchant.count
  end

  def test_it_can_find_the_average_number_of_items_per_merchant
    skip
    assert_equal 2.88, @sa.average_items_per_merchant
  end
end
