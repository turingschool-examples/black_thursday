require_relative 'test_helper'
require_relative '../lib/sales_analyst'
require_relative '../lib/sales_engine'
require_relative 'sales_engine_methods'

class SalesAnalystTest < Minitest::Test
  include SalesEngineMethods
  attr_reader :se, :sa

  def setup
    create_sales_engine
    @sa = SalesAnalyst.new(se)
  end

  def test_it_exists
    assert_instance_of SalesAnalyst, sa
  end

  def test_it_calculates_average_items_per_merchant
    assert_equal 2.33, sa.average_items_per_merchant
  end

  def test_it_calculates_standard_deviation
    assert_equal 1.53, sa.average_items_per_merchant_standard_deviation
  end

  def test_knows_merchants_with_highest_item_count
    assert_equal Array, sa.merchants_with_high_item_count.class
    assert_equal 12334122, sa.merchants_with_high_item_count.first.id
  end

  def test_it_knows_average_item_price_for_merchant
    assert_instance_of BigDecimal, sa.average_item_price_for_merchant(12334185)
    assert_equal 97.90, sa.average_item_price_for_merchant(12334185).to_f
  end

  def test_it_knows_average_of_average_price_per_merchant
    assert_instance_of BigDecimal, sa.average_average_price_per_merchant
    assert_equal 96.41, sa.average_average_price_per_merchant.to_f
  end

  def test_it_calculates_average_item_price
    assert_equal 96.20, sa.average_item_price
  end

  def test_it_calculates_item_price_standard_deviation
    assert_equal 2.17, sa.item_price_standard_deviation
  end

  def test_it_knows_golden_items
    assert_instance_of Array, sa.golden_items
    assert_equal "DINO EGGS", sa.golden_items.first.name
  end

  def test_it_can_calculate_average_invoices_per_merchant
    assert_equal 9.67, sa.average_invoices_per_merchant
  end

  def test_it_can_calculate_standard_deviation_for_invoices_per_merchant
    assert_equal 9.19, sa.average_invoices_per_merchant_standard_deviation
  end

  def test_it_can_calculate_top_merchants_by_invoice_count
    se = SalesEngine.from_csv({
        :merchants     => "./test/fixtures/merchants_for_invoices_test.csv",
        :items     => "./test/fixtures/items_test.csv",
        :invoices => "./test/fixtures/invoices_test.csv"
        })
    sa2 = SalesAnalyst.new(se)

    assert_instance_of Array, sa2.top_merchants_by_invoice_count
    assert_instance_of Merchant, sa2.top_merchants_by_invoice_count.first
    assert_equal "DinoSeller", sa2.top_merchants_by_invoice_count.first.name
  end

  def test_it_can_calculate_bottom_merchants_by_invoice_count
    se = SalesEngine.from_csv({
      :merchants     => "./test/fixtures/merchants_for_invoices_test.csv",
      :items     => "./test/fixtures/items_test.csv",
      :invoices => "./test/fixtures/invoices_bottom_test.csv"
      })
    sa2 = SalesAnalyst.new(se)

    assert_instance_of Array, sa2.bottom_merchants_by_invoice_count
    assert_instance_of Merchant, sa2.bottom_merchants_by_invoice_count.first
    assert_equal "Shopin1901", sa2.bottom_merchants_by_invoice_count.first.name
  end

  def test_it_can_calculate_top_days_by_invoice_count
    se = SalesEngine.from_csv({
        :merchants     => "./test/fixtures/merchants_for_invoices_test.csv",
        :items     => "./test/fixtures/items_test.csv",
        :invoices => "./test/fixtures/invoices_test.csv"
        })
    sa2 = SalesAnalyst.new(se)

    assert_instance_of Array, sa2.top_days_by_invoice_count
    assert_equal 1, sa2.top_days_by_invoice_count.count
    assert_equal "Saturday", sa2.top_days_by_invoice_count.first
  end

  def test_it_can_find_percentage_of_invoices_by_status
    assert_instance_of Float, sa.invoice_status(:pending)
    assert_equal 58.62, sa.invoice_status(:pending)
    assert_equal 34.48, sa.invoice_status(:shipped)
    assert_equal 6.9, sa.invoice_status(:returned)
  end

  def test_it_can_find_total_revenue_by_given_date
    assert_instance_of BigDecimal, sa.total_revenue_by_date(Time.parse("2009-02-05"))
    assert_equal 12922.97, sa.total_revenue_by_date(Time.parse("2009-02-05")).to_f
  end

  def test_it_can_calculate_revenue_by_merchant
    assert_instance_of BigDecimal, sa.revenue_by_merchant(12334122)
    assert_equal 12922.97, sa.revenue_by_merchant(12334122).to_f
  end

  def test_it_calculates_merchants_ranked_by_revenue
    assert_instance_of Array, sa.merchants_ranked_by_revenue
    assert_instance_of Merchant, sa.merchants_ranked_by_revenue.first
    assert_equal 3, sa.merchants_ranked_by_revenue.count
    assert_equal 12334122, sa.merchants_ranked_by_revenue.first.id
  end

  def test_it_can_find_top_x_number_of_revenue_earners
    assert_instance_of Array, sa.top_revenue_earners(1)
    assert_equal 1, sa.top_revenue_earners(1).count
    assert_instance_of Merchant, sa.top_revenue_earners(1).first
  end

  def test_it_can_return_merchants_with_pending_invoices
    assert_instance_of Array, sa.merchants_with_pending_invoices
    assert_instance_of Merchant, sa.merchants_with_pending_invoices.first
    assert_equal 1, sa.merchants_with_pending_invoices.count
    assert_equal 12334185, sa.merchants_with_pending_invoices.first.id
  end

  def test_it_returns_merchants_with_only_one_item
    assert_instance_of Array, sa.merchants_with_only_one_item
    assert_instance_of Merchant, sa.merchants_with_only_one_item.first
    assert_equal 1, sa.merchants_with_only_one_item.count
    assert_equal 12334105, sa.merchants_with_only_one_item.first.id
  end

  def test_it_can_return_merchants_with_only_one_item_in_a_month
    assert_instance_of Array, sa.merchants_with_only_one_item_registered_in_month("December")
    assert_instance_of Merchant, sa.merchants_with_only_one_item_registered_in_month("December").first
    assert_equal 1, sa.merchants_with_only_one_item_registered_in_month("December").count
    assert_equal 12334105, sa.merchants_with_only_one_item_registered_in_month("December").first.id
  end

  def test_it_can_return_invoice_items_for_paid_invoices
    assert_instance_of Array, sa.paid_merchant_invoices(12334122)
    assert_instance_of InvoiceItem, sa.paid_merchant_invoices(12334122).first
    assert_equal 2, sa.paid_merchant_invoices(12334122)[1].id
  end

  def test_it_knows_quantity_of_invoice_items_for_merchant
    assert_instance_of Hash, sa.quantity_of_item(12334122)
    assert_instance_of InvoiceItem, sa.quantity_of_item(12334122).keys.first
    assert_equal 1, sa.quantity_of_item(12334122).keys.first.id
  end

  def test_it_knows_top_item_for_merchant
    assert_instance_of Array, sa.most_sold_item_for_merchant(12334122)
    assert_instance_of Item, sa.most_sold_item_for_merchant(12334122).first
    assert_equal 263454779, sa.most_sold_item_for_merchant(12334122).first.id
  end

  def test_it_can_find_item_revenue_for_merchant
    assert_instance_of Hash, sa.item_revenue_for_merchant(12334122)
    assert_instance_of InvoiceItem, sa.item_revenue_for_merchant(12334122).keys.first
    assert_equal 1, sa.item_revenue_for_merchant(12334122).keys.first.id
  end

  def test_it_can_find_best_item_for_merchant
    assert_instance_of Item, sa.best_item_for_merchant(12334122)
    assert_equal 263432817, sa.best_item_for_merchant(12334122).id
  end

end

