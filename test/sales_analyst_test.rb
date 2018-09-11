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
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
    })
    sa = se.analyst
    assert_instance_of MerchantRepository, se.merchants
    assert_instance_of ItemRepository, se.items
  end

  def test_it_calculates_average_items_per_merchant
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
    })
    sa = se.analyst
    assert_equal 2.88, sa.average_items_per_merchant
  end

  def test_it_calculates_standard_deviation
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
    })
    sa = se.analyst
    assert_equal 3.26, sa.average_items_per_merchant_standard_deviation
  end

  def test_it_finds_merchants_with_high_item_count
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
    })
    sa = se.analyst

    # update expected
    expected = 52
    assert_equal expected, sa.merchants_with_high_item_count.count
  end

  def test_it_finds_average_item_price_for_merchant
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
    })
    sa = se.analyst

    expected = BigDecimal(31.5, 4)
    assert_equal expected, sa.average_item_price_for_merchant(12334159)
  end

  def test_it_finds_average_average_price_per_merchant
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
    })
    sa = se.analyst

    expected = BigDecimal(350.29, 5)
    assert_equal expected, sa.average_average_price_per_merchant
  end

end
