require_relative 'test_helper'
require_relative '../lib/sales_analyst'
require_relative '../lib/sales_engine'
require_relative '../lib/merchant_repo'
require_relative '../lib/item_repo'
require_relative '../lib/invoice_repo'
require 'bigdecimal'

class SalesAnalystTest < Minitest::Test
  attr_reader :se, :sa
  def set_up
    files = ({:invoices => "./test/fixtures/invoice_fixture.csv", :items => "./test/fixtures/item_fixture.csv", :merchants => "./test/fixtures/merchant_fixture.csv"})
    @se = SalesEngine.from_csv(files)
    @sa = SalesAnalyst.new(se)
  end

  def test_it_exists
    assert_instance_of SalesAnalyst, set_up
  end

  def test_average_items_per_merchant
    assert_equal 0.83, set_up.average_items_per_merchant
  end

  def test_find_averages
    assert_equal 6, set_up.counts_per_merchant(se.method(:find_merchant_items)).count
  end

  def test_standard_deviation
    files = ({:invoices => "./test/fixtures/invoice_fixture.csv", :items => "./data/items.csv", :merchants => "./data/merchants.csv"})
    se = SalesEngine.from_csv(files)
    sales_a = SalesAnalyst.new(se)

    assert_equal 3.26, sales_a.average_items_per_merchant_standard_deviation
  end

  def test_merchants_with_high_item_count
    files = ({:invoices => "./test/fixtures/invoice_fixture.csv", :items => "./data/items.csv", :merchants => "./data/merchants.csv"})
    se = SalesEngine.from_csv(files)
    sales_a = SalesAnalyst.new(se)

    assert_equal 52, sales_a.merchants_with_high_item_count.count
  end

  def test_average_item_price_for_merchant
    files = ({:invoices => "./test/fixtures/invoice_fixture.csv", :items => "./data/items.csv", :merchants => "./data/merchants.csv"})
    se = SalesEngine.from_csv(files)
    sales_a = SalesAnalyst.new(se)

    assert_equal  0.315e2, sales_a.average_item_price_for_merchant(12334159)
  end

  def test_average_average_price_per_merchant
    files = ({:invoices => "./test/fixtures/invoice_fixture.csv", :items => "./data/items.csv", :merchants => "./data/merchants.csv"})
    se = SalesEngine.from_csv(files)
    sales_a = SalesAnalyst.new(se)

    assert_equal BigDecimal.new('0.350294697495132463357977937150568421052631578947e3').round(2), sales_a.average_average_price_per_merchant
  end

  def test_average_item_price
    set_up

    assert_equal BigDecimal.new("0.15098e2"), sa.mean(sa.item_unit_price_list)
  end

  def test_standard_deviation_of_item_price
    assert_equal 8.72, set_up.std_deviation_of_item_price
  end

  def test_golden_items
    assert_equal 1, set_up.golden_items.count
  end

  def test_average_invoices_per_merchant
    assert_equal 1.67, set_up.average_invoices_per_merchant
  end

  def test_average_invoices_per_merchant_standard_deviation
    files = ({:invoices => "./data/invoices.csv", :items => "./data/items.csv", :merchants => "./data/merchants.csv"})
    se = SalesEngine.from_csv(files)
    sales_a = SalesAnalyst.new(se)

    assert_equal 3.29, sales_a.average_invoices_per_merchant_standard_deviation
  end

  def test_top_merchants_by_invoice_count
    files = ({:invoices => "./data/invoices.csv", :items => "./data/items.csv", :merchants => "./data/merchants.csv"})
    se = SalesEngine.from_csv(files)
    sales_a = SalesAnalyst.new(se)


    assert_equal 12, sales_a.top_merchants_by_invoice_count.count
  end

  def test_bottom_merchants_by_invoice_count
    files = ({:invoices => "./data/invoices.csv", :items => "./data/items.csv", :merchants => "./data/merchants.csv"})
    se = SalesEngine.from_csv(files)
    sales_a = SalesAnalyst.new(se)


    assert_equal 4, sales_a.bottom_merchants_by_invoice_count.count
  end

  def test_top_days_by_invoice_count
    files = ({:invoices => "./data/invoices.csv", :items => "./data/items.csv", :merchants => "./data/merchants.csv"})
    se = SalesEngine.from_csv(files)
    sales_a = SalesAnalyst.new(se)

    assert_equal 1, sales_a.top_days_by_invoice_count.count
  end
  
  def test_invoice_status_percentage
    files = ({:invoices => "./data/invoices.csv", :items => "./data/items.csv", :merchants => "./data/merchants.csv"})
    se = SalesEngine.from_csv(files)
    sales_a = SalesAnalyst.new(se)

    assert_equal  29.55, sales_a.invoice_status(:pending)
    assert_equal  56.95, sales_a.invoice_status(:shipped)
    assert_equal  13.5, sales_a.invoice_status(:returned)
  end
end
