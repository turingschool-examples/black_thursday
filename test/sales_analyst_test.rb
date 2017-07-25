require './lib/sales_engine'
require './lib/sales_analyst'
require 'minitest/autorun'
require 'minitest/pride'
require 'bigdecimal'

class SalesAnalystTest < Minitest::Test
  def setup
    @se = SalesEngine.from_csv({
          :items     => "./data/items.csv",
          :merchants => "./data/merchants.csv",
          })

    @sa = SalesAnalyst.new(@se)
  end

  def test_class_exists
    assert_instance_of SalesAnalyst, @sa
  end

  def test_average_items_per_merchant
    assert_equal 2.88, @sa.average_items_per_merchant
  end

  def test_average_items_per_merchant_standard_deviation

  end

end
