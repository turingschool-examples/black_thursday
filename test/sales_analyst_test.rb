require_relative './helper'
require_relative '../lib/sales_engine'
class SalesAnalystTest < Minitest::Test
  def setup
    se = SalesEngine.from_csv( {
        :items      => './data/items.csv',
        :merchants  => './data/merchants.csv'
                                } )
    @sa = se.analyst
  end

  def test_it_exists
    assert_instance_of SalesAnalyst, @sa
  end

  def test_it_can_return_average_items_per_merchant
    assert_equal 2.88, @sa.average_items_per_merchant
  end
end
