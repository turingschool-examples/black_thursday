require './test/test_helper'
require './lib/sales_engine'
require './lib/sales_analyst'

class SalesAnalystTest < Minitest::Test
  def setup
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoices  => "./data/invoices.csv",
      :invoice_items => "./data/invoice_items.csv",
      :transactions => "./data/transactions.csv",
      :customers => "./data/customers.csv"
    })

    @sa = se.analyst
  end

  # def test_it_exists
  #   skip
  #   assert_instance_of SalesAnalyst, @sa
  # end

  # def test_it_has_repos
  #   skip
  #   assert_instance_of ItemsRepository, @sa.items
  #   assert_instance_of MerchantRepo, @sa.merchants
  # end

  # def test_average_items_per_merchant
  #   skip
  #   assert_equal 2.88, @sa.average_items_per_merchant
  # end

  # def test_average_item_price_for_merchant
  #   skip
  #   merchant_id = 12334159
  #   avg_price = @sa.average_item_price_for_merchant(merchant_id)
  #   assert_instance_of BigDecimal, avg_price
  # end

  # def test_average_average_price_per_merchant
  #   skip
  #   avg_avg = @sa.average_average_price_per_merchant
  #   assert_instance_of BigDecimal, avg_avg
  # end

  # def test_average_items_per_merchant_standard_deviation
  #   skip
  #   assert_equal 3.26, @sa.average_items_per_merchant_standard_deviation
  # end

  # def test_merchants_with_high_item_count
  #   skip
  #   assert_equal 52, @sa.merchants_with_high_item_count.length
  # end

  # def test_golden_items
  #   skip
  #   assert_equal 5, @sa.golden_items.length
  # end

  # def test_average_invoices_per_merchant
  #   skip
  #   assert_equal 10.49, @sa.average_invoices_per_merchant
  # end

  # def test_average_invoices_per_merchant_standard_deviation
  #   skip
  #   assert_equal 3.29, @sa.average_invoices_per_merchant_standard_deviation
  # end

  # def test_top_merchants_by_invoice_count
  #   skip
  #   assert_instance_of Merchant, @sa.top_merchants_by_invoice_count.first
  #   assert_equal 12, @sa.top_merchants_by_invoice_count.length
  # end

  # def test_bottom_merchants_by_invoice_count
  #   skip
  #   assert_instance_of Merchant, @sa.bottom_merchants_by_invoice_count.first
  #   assert_equal 4, @sa.bottom_merchants_by_invoice_count.length
  # end

  # def test_top_days_by_invoice_count
  #   skip
  #   assert_equal 1, @sa.top_days_by_invoice_count.length
  #   assert_equal "Wednesday", @sa.top_days_by_invoice_count.first
  # end

  # def test_invoice_status
  #   skip
  #   assert_equal 29.55, @sa.invoice_status(:pending)


  #   assert_equal 56.95, @sa.invoice_status(:shipped)


  #   assert_equal 13.5, @sa.invoice_status(:returned)
  # end

  # def test_invoice_paid_in_full?
  #   assert_equal true, @sa.invoice_paid_in_full?(1)
  #   assert_equal false, @sa.invoice_paid_in_full?(203)
  #   assert_equal false, @sa.invoice_paid_in_full?(204)
  # end

  # def test_invoice_total
  #   @sa.invoice_total(1)

  #   assert_equal 21067.77, @sa.invoice_total(1)
  #   assert_equal BigDecimal, @sa.invoice_total(1).class
  # end

  def test_top_buyers
    actual = @sa.top_buyers(5)

    assert_equal 5, actual.length
    assert_equal 313, actual.first.id
    assert_equal 478, actual.last.id
  end
end
















