require 'simplecov'
SimpleCov.start

require 'minitest/autorun'
require 'minitest/pride'

require './lib/sales_analyst'

# Sales Analyst test class
class SalesAnalystTest < Minitest::Test

  def test_it_exists
    sa = SalesAnalyst.new
    assert_instance_of SalesAnalyst, sa
  end

  def test_it_calculates_avarage_items_per_merchant
    skip

  end

  def test_it_calculates_avarage_items_per_merchant_standard_devation
    skip
  end

  def test_it_calculates_merchants_with_high_item_count
    skip
  end

  def test_it_calculates_avarage_item_price_for_merchant
    skip
    #takes argument of merchant id
  end

  def test_it_calculates_avarage_price_per_merchant
    skip
  end

  def test_it_identifies_golden_items
    skip
  end
end
