require_relative 'test_helper'
require_relative '../lib/sales_analyst'
require_relative '../lib/sales_engine'
require 'bigdecimal'
require 'pry'

class SalesAnalystTest < Minitest::Test

  def setup
    @sales_engine = SalesEngine.from_csv({
          :items     => "./data/items.csv",
          :merchants => "./data/merchants.csv",
          })
    @sales_analyst = @sales_engine.analyst
  end

  def test_it_exists
    assert_instance_of SalesAnalyst, @sales_analyst
  end

  def test_it_gives_average_items_per_merchant
    actual = @sales_analyst.average_items_per_merchant
    expected = 2.88

    assert_equal expected, actual
  end

  def test_it_calculates_standard_deviation
    actual = @sales_analyst.average_items_per_merchant_standard_deviation
    expected = 3.26

    assert_equal expected, actual
  end

  def test_find_merchants_with_high_item_count
    skip
    high_item_merchants = @sales_analyst.merchants_with_high_item_count
    a = high_item_merchants.map do |merchant|
      merchant.id
    end
    b = a.map do |id|
      @sales_analyst.items.find_all_by_merchant_id(id)
    end
    binding.pry
    c = b.all? do |number|
      number >= 6.14
    end
      assert_equal true, c
  end

  def test_it_calculates_average_price_for_specific_merchant
    skip
    actual = @sales_analyst.average_item_price_for_merchant(12334193)
    expected = 29.99

    assert_instance_of BigDecimal, actual
    assert_equal expected, actual.to_f
  end

end
