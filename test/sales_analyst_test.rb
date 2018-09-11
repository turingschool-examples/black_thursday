require_relative '../test/test_helper'
require_relative '../lib/sales_analyst'
require_relative '../lib/sales_engine'

class SalesAnalystTest < Minitest::Test

  def test_it_exists
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
    })
    sa = se.analyst
    assert_instance_of SalesAnalyst, sa
  end

  def test_it_has_attributes
    skip
    sa = SalesAnalyst.new
    assert_instance_of MerchantRepository, sa.mr
    assert_instance_of ItemRepository, sa.ir
  end

  def test_it_calculates_average_items_per_merchant
    skip
    sa = SalesAnalyst.new
    assert_equal 2.88, sa.average_items_per_merchant
  end
end
