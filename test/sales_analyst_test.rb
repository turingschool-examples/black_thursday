require './test/test_helper'

class SalesAnalystTest < Minitest::Test

  attr_reader :se, :sa

  def setup 
    @se = SalesEngine.from_csv({
    :items     => "./data/items.csv",
    :merchants => "./data/merchants.csv",
    })
    @sa = SalesAnalyst.new(se)
  end

  def test_it_exists
    assert_instance_of SalesAnalyst, SalesAnalyst.new(se)
  end

  def test_average_items_per_merchant
    assert_equal 2.88, sa.average_items_per_merchant
  end

  def test_average_items_per_merchant_standard_deviation
    assert_equal 3.26, sa.average_items_per_merchant_standard_deviation
  end
  
  def test_merchants_with_high_item_count
    assert_equal 52,  sa.merchants_with_high_item_count.length
  end

  def test_average_item_price_for_merchant
    assert_instance_of BigDecimal, sa.average_item_price_for_merchant(12334159)
  end

  def test_average_average_price_per_merchant
    assert_instance_of BigDecimal, sa.average_item_price_per_merchant
  end

  def test_golden_items
    assert_equal 27, sa.golden_items.length
  end


end

