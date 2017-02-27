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

  # need a test for item price av that would give 3 decimal places

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
    se2 = SalesEngine.from_csv({
        :merchants     => "./test/fixtures/merchants_for_invoices_test.csv",
        :items     => "./test/fixtures/items_test.csv",
        :invoices => "./test/fixtures/invoices_test.csv"
        })
    sa2 = SalesAnalyst.new(se2)

    assert_instance_of Array, sa2.top_merchants_by_invoice_count
    assert_instance_of Merchant, sa2.top_merchants_by_invoice_count.first
    assert_equal "DinoSeller", sa2.top_merchants_by_invoice_count.first.name
  end

  def test_it_can_calculate_bottom_merchants_by_invoice_count
    se2 = SalesEngine.from_csv({
      :merchants     => "./test/fixtures/merchants_for_invoices_test.csv",
      :items     => "./test/fixtures/items_test.csv",
      :invoices => "./test/fixtures/invoices_bottom_test.csv"
      })
    sa2 = SalesAnalyst.new(se2)

    assert_instance_of Array, sa2.bottom_merchants_by_invoice_count
    assert_instance_of Merchant, sa2.bottom_merchants_by_invoice_count.first
    assert_equal "Shopin1901", sa2.bottom_merchants_by_invoice_count.first.name
  end

  def test_it_can_calculate_top_days_by_invoice_count
    se2 = SalesEngine.from_csv({
        :merchants     => "./test/fixtures/merchants_for_invoices_test.csv",
        :items     => "./test/fixtures/items_test.csv",
        :invoices => "./test/fixtures/invoices_test.csv"
        })
    sa2 = SalesAnalyst.new(se2)

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

end

