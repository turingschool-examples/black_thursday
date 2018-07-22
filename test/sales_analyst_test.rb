require_relative 'test_helper'
require_relative '../lib/sales_analyst'
require_relative '../lib/sales_engine'

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
    actual = @sales_analyst.merchants_with_high_item_count
    merchant_ids = actual.map do |merchant|
      merchant.id
    end

    assert merchant_ids.all? do |merchant_id|
      @sales_analyst.items.find_all_by_merchant_id(merchant_id).count >= 6.14
    end

  end

end
