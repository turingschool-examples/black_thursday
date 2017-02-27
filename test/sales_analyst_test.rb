require './test/test_helper'

class SalesAnalystTest < Minitest::Test

  attr_reader :se, :sa

  def setup
    @se = SalesEngine.from_csv({
    :items     => "./data/items.csv",
    :merchants => "./data/merchants.csv",
    :invoices  => "./data/invoices.csv"
    })
    @sa = SalesAnalyst.new(se)
  end

  def test_it_exists
    assert_instance_of SalesAnalyst, sa
  end

  def test_merchant_repository_navigates
    assert_instance_of MerchantRepository , sa.merchant_repository
  end

  def test_item_repositroy_navigation
    assert_instance_of ItemRepository , sa.item_repository
  end

  def test_average_items_per_merchant
    assert_equal 475, sa.items_per_merchant
  end

  def test_price_of_items_per_merchant
    assert_instance_of Array, sa.price_of_items_per_merchant(12334105)
    price_map = sa.price_of_items_per_merchant(12334105)
    assert_instance_of BigDecimal, price_map[0]
  end

  def test_price_per_item
    assert_instance_of Array, sa.price_per_item
    assert_equal 1367, sa.price_per_item.length
  end

  def test_average_price_per_item
    avg = sa.average_price_per_item
    assert_instance_of BigDecimal, avg
    assert_equal 251.06, avg.to_f
  end

  def test_average_items_per_merchant
    assert_equal 2.88, sa.average_items_per_merchant
  end

  def test_average_items_per_merchant_standard_deviation
    assert_equal 3.26, sa.average_items_per_merchant_standard_deviation
  end

  def test_merchants_with_high_item_count
    top_merchants = sa.merchants_with_high_item_count.length
    assert_equal 52, top_merchants
  end

  def test_average_item_price_for_merchant
    avg = sa.average_item_price_for_merchant(12334159)
    assert_instance_of BigDecimal, avg
    assert_equal 31.5, avg.to_f
  end

  def test_average_average_price_per_merchant
    avg_avg = sa.average_average_price_per_merchant
    assert_instance_of BigDecimal, avg_avg
    assert_equal 350.29, avg_avg.to_f
  end

  def test_golden_items
    golden_items = sa.golden_items
    assert_instance_of Array, golden_items
    assert_equal 5, golden_items.length
    assert_equal "Test listing", golden_items[0].name
  end

#---------------------Invoice Analyst-----------------------

  def test_average_invoices_per_merchant
    assert_equal 10.49, sa.average_invoices_per_merchant
  end

  def test_average_invoices_per_merchant_standard_deviation
    assert_equal 3.29, sa.average_invoices_per_merchant_standard_deviation
  end

  def test_top_merchants_by_invoice_count
    top_merchants_list = sa.top_merchants_list_by_invoice_count
    assert_instance_of Array, top_merchants_list
    assert_equal 23,top_merchants_list.length
    top_merchant = top_merchants_list[0]
    assert_equal "name of merchant", top_merchant.name
  end

  def test_top_merchants_by_invoice_count
    skip
    top_merchants_list = sa.top_merchants_list_by_invoice_count
    assert_instance_of Array, top_merchants_list
    assert_equal 23,top_merchants_list.length
    top_merchant = top_merchants_list[-1]
    assert_equal "name of merchant", top_merchant.name
  end

  def test_top_days_by_invoice_count
    skip
    assert_equal ["Sunday", "Saturday"], sa.top_days_by_invoice_count
  end
end
