require './test/test_helper'
require './lib/sales_analyst'

class MerchantAnalystTest < Minitest::Test

  def test_it_can_find_one_merchant
    se = SalesEngine.from_csv({ items: "./test/samples/item_sample.csv", merchants: "./test/samples/merchants_sample.csv" })
    ma = SalesAnalyst.new(se).merchant_analyst

    assert_equal "Shopin1901", ma.find_merchant(12334105).name
  end

  def test_it_can_find_the_average_items_per_merchant
    se = SalesEngine.from_csv({ items: "./test/samples/item_sample.csv", merchants: "./test/samples/merchants_sample.csv" })
    ma = SalesAnalyst.new(se).merchant_analyst
    assert_equal 0.2, ma.average_items_per_merchant
  end

  def test_standard_deviation_returns_a_float
    se = SalesEngine.from_csv({ items: "./test/samples/item_sample.csv", merchants: "./test/samples/merchants_sample.csv" })
    ma = SalesAnalyst.new(se).merchant_analyst

    assert ma.average_items_per_merchant_standard_deviation.is_a?(Float)
  end

  def test_it_can_calculate_standard_deviation
    se = SalesEngine.from_csv({ items: "./test/samples/item_sample.csv", merchants: "./test/samples/merchants_sample.csv" })
    ma = SalesAnalyst.new(se).merchant_analyst

    assert_equal 0.83, ma.average_items_per_merchant_standard_deviation
  end

  def test_it_can_find_total_item_price_for_a_merchant
    se = SalesEngine.from_csv({ items: "./test/samples/item_sample.csv", merchants: "./test/samples/merchants_sample.csv" })
    ma = SalesAnalyst.new(se).merchant_analyst
    merchant = ma.find_merchant(12334185)

    assert_equal BigDecimal(33.50, 4), ma.total_item_price_for_merchant(merchant)
  end

  def test_it_can_find_average_item_price_for_a_merchant
    se = SalesEngine.from_csv({ items: "./test/samples/item_sample.csv", merchants: "./test/samples/merchants_sample.csv" })
    ma = SalesAnalyst.new(se).merchant_analyst

    assert_equal BigDecimal(11.17, 4), ma.average_item_price_for_merchant(12334185)
  end

  def test_average_item_price_returns_nil_for_an_itemless_merchant
    se = SalesEngine.from_csv({ items: "./test/samples/item_sample.csv", merchants: "./test/samples/merchants_sample.csv" })
    ma = SalesAnalyst.new(se).merchant_analyst

    assert_equal nil, ma.average_item_price_for_merchant(12334496)
  end

  def test_average_item_price_returns_nil_for_a_nonexistent_merchant
    se = SalesEngine.from_csv({ items: "./test/samples/item_sample.csv", merchants: "./test/samples/merchants_sample.csv" })
    ma = SalesAnalyst.new(se).merchant_analyst

    assert_equal nil, ma.average_item_price_for_merchant(99999999)
  end

  def test_it_can_find_active_merchants
    se = SalesEngine.from_csv({ items: "./test/samples/item_sample.csv", merchants: "./test/samples/merchants_sample.csv" })
    ma = SalesAnalyst.new(se).merchant_analyst

    assert_equal 10, ma.active_merchants.length
  end

  def test_it_can_find_total_of_all_averages
    se = SalesEngine.from_csv({ items: "./test/samples/item_sample.csv", merchants: "./test/samples/merchants_sample.csv" })
    ma = SalesAnalyst.new(se).merchant_analyst

    assert_equal BigDecimal(710.38, 5), ma.total_item_price_for_active_merchants
  end

  def test_it_can_find_average_average_item_price_for_all_merchants
    se = SalesEngine.from_csv({ items: "./test/samples/item_sample.csv", merchants: "./test/samples/merchants_sample.csv" })
    ma = SalesAnalyst.new(se).merchant_analyst

    assert_equal BigDecimal(71.03, 4), ma.average_average_price_per_merchant
  end

  def test_average_average_returns_nil_with_no_merchants
    se = SalesEngine.from_csv({ items: "./test/samples/item_sample.csv", merchants: "./test/samples/empty_file.csv" })
    ma = SalesAnalyst.new(se).merchant_analyst

    assert_equal nil, ma.average_average_price_per_merchant
  end

  def test_average_average_returns_nil_with_no_items
    se = SalesEngine.from_csv({ items: "./test/samples/empty_file.csv", merchants: "./test/samples/merchants_sample.csv" })
    ma = SalesAnalyst.new(se).merchant_analyst

    assert_equal nil, ma.average_average_price_per_merchant
  end

  def test_it_can_find_merchants_with_high_items_count
    se = SalesEngine.from_csv({ items: "./test/samples/item_sample.csv", merchants: "./test/samples/merchants_sample.csv" })
    ma = SalesAnalyst.new(se).merchant_analyst

    assert_equal 4, ma.merchants_with_high_item_count.length
  end

  def test_it_can_find_average_invoices_per_merchant
    se = SalesEngine.from_csv({ items: "./test/samples/item_sample.csv", merchants: "./test/samples/merchants_sample.csv", invoices: "./test/samples/invoices_sample.csv" })
    ma = SalesAnalyst.new(se).merchant_analyst

    assert_equal 0.18, ma.average_invoices_per_merchant
  end

  def test_it_can_find_standard_deviation_of_invoices_per_merchant
    se = SalesEngine.from_csv({ items: "./test/samples/item_sample.csv", merchants: "./test/samples/merchants_sample.csv", invoices: "./test/samples/invoices_sample.csv" })
    ma = SalesAnalyst.new(se).merchant_analyst

    assert_equal 0.4, ma.average_invoices_per_merchant_standard_deviation
  end

  def test_it_can_find_top_merchants_by_invoice_count
    se = SalesEngine.from_csv({ items: "./test/samples/item_sample.csv", merchants: "./test/samples/merchants_sample.csv", invoices: "./test/samples/invoices_sample.csv" })
    ma = SalesAnalyst.new(se).merchant_analyst
    ma.stub :average_invoices_per_merchant, 0.5 do
      assert_equal 1, ma.top_merchants_by_invoice_count.length
    end
  end

  def test_it_can_find_bottom_merchants_by_invoice_count
    se = SalesEngine.from_csv({ items: "./test/samples/item_sample.csv", merchants: "./test/samples/merchants_sample.csv", invoices: "./test/samples/invoices_sample.csv" })
    ma = SalesAnalyst.new(se).merchant_analyst
    ma.stub :average_invoices_per_merchant_standard_deviation, 0.01 do
      assert_equal 83, ma.bottom_merchants_by_invoice_count.length
    end
  end

end
