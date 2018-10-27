require './test/test_helper'

class SalesAnalystTest < Minitest::Test

  def setup
    @sales_engine = SalesEngine.from_csv({
        :items     => "./data/items.csv",
        :merchants => "./data/merchants.csv",
        :invoices  => "./data/invoices.csv",
        :invoice_items => "./data/invoice_items.csv"
      })
    @sales_analyst = @sales_engine.analyst
  end

  def test_it_exists
    assert_instance_of SalesAnalyst, @sales_analyst
  end

  def test_it_returns_avg_items_per_merchant
    assert_equal 2.88, @sales_analyst.average_items_per_merchant
  end

  def test_it_returns_merchant_item_list
    merchant = @sales_analyst.merchants[4]
    item_list = @sales_analyst.merchant_item_list(merchant)
    assert_equal 25, item_list.count
  end

  def test_avg_items_per_merchant_std_dev
    std_dev = @sales_analyst.average_items_per_merchant_standard_deviation
    assert_equal 3.26, std_dev
  end

  def test_merchants_with_high_item_count
    hicmerchs = @sales_analyst.merchants_with_high_item_count
    assert_instance_of Array, hicmerchs
    assert_equal 52, hicmerchs.count
  end

  def test_avg_price_for_a_merchant
    actual = @sales_analyst.average_item_price_for_merchant(12334159)
    assert_instance_of BigDecimal, actual
    assert_equal 31.50, actual.to_f.round(2)
  end

  def test_avg_avg_price_per_merchant
    actual = @sales_analyst.average_average_price_per_merchant
    assert_instance_of BigDecimal, actual
    assert_equal 350.29, actual.to_f.round(2)
  end

  def test_avg_item_price
    actual = @sales_analyst.average_item_price
    assert_instance_of BigDecimal, actual
    assert_equal 251.06, actual.to_f.round(2)
  end

  def test_avg_item_price_std_dev
    actual = @sales_analyst.average_item_price_std_dev
    assert_instance_of BigDecimal, actual
    assert_equal 2900.99, actual.to_f.round(2)
  end

  def test_golden_items
    actual = @sales_analyst.golden_items
    assert_instance_of Array, actual
    assert_equal 5, actual.count
  end

  def test_average_invoices_per_merchant
    # number of invoices / number of merchants
    #all method
    actual = @sales_analyst.average_invoices_per_merchant
    #@invoices.id.count / 
    assert_equal 10.49, actual
  end

end
