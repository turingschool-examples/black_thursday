require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/sales_analyst'

class InvoiceAnalyticsTest < Minitest::Test

  def test_include
    sales_engine = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoices => "./data/invoices.csv"
    })
    sales_analyst = SalesAnalyst.new(sales_engine)

    refute_equal nil, sales_analyst.invoices
    refute_equal nil, sales_analyst.average_invoices_per_day
  end

  def test_average_invoices_per_merchant
    sales_engine = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoices => "./data/invoices.csv"
    })
    sales_analyst = SalesAnalyst.new(sales_engine)

    assert_equal 10.49, sales_analyst.average_invoices_per_merchant
  end

  def test_average_invoices_per_merchant_standard_deviation
    sales_engine = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoices => "./data/invoices.csv"
    })
    sales_analyst = SalesAnalyst.new(sales_engine)

    assert_equal 3.29, sales_analyst.average_invoices_per_merchant_standard_deviation
  end

  def test_top_merchants_by_invoice_count
    sales_engine = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoices => "./data/invoices.csv"
    })
    sales_analyst = SalesAnalyst.new(sales_engine)

    top_merchants = sales_analyst.top_merchants_by_invoice_count

    assert_instance_of Array, top_merchants
    assert_instance_of Merchant, top_merchants[0]
  end

  def test_bottom_merchants_by_invoice_count
    sales_engine = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoices => "./data/invoices.csv"
    })
    sales_analyst = SalesAnalyst.new(sales_engine)

    bottom_merchants = sales_analyst.bottom_merchants_by_invoice_count

    assert_instance_of Array, bottom_merchants
    assert_instance_of Merchant, bottom_merchants[0]
  end

  def test_average_invoices_per_day
    sales_engine = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoices => "./data/invoices.csv"
    })
    sales_analyst = SalesAnalyst.new(sales_engine)

    assert_equal 712.14, sales_analyst.average_invoices_per_day
  end

  def test_average_invoices_per_day_standard_deviation
    sales_engine = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoices => "./data/invoices.csv"
    })
    sales_analyst = SalesAnalyst.new(sales_engine)

    assert_equal 0.63, sales_analyst.average_invoices_per_day_standard_deviation
  end

  def test_top_days_by_invoice_count
    sales_engine = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoices => "./data/invoices.csv"
    })
    sales_analyst = SalesAnalyst.new(sales_engine)

    top_days = sales_analyst.top_days_by_invoice_count

    assert_instance_of Array, top_days
    assert_instance_of Symbol, top_days[0]
    assert_equal 3, top_days.length
  end

  def test_invoice_status
    sales_engine = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoices => "./data/invoices.csv"
    })
    sales_analyst = SalesAnalyst.new(sales_engine)

    pending = sales_analyst.invoice_status(:pending)
    shipped = sales_analyst.invoice_status(:shipped)
    returned = sales_analyst.invoice_status(:returned)

    assert_equal 29.55, pending
    assert_equal 56.95, shipped
    assert_equal 13.5, returned
  end

  def test_merchants_with_pending_invoices
    sales_engine = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoices => "./data/invoices.csv"
    })
    sales_analyst = SalesAnalyst.new(sales_engine)

    pending_merchants = sales_analyst.merchants_with_pending_invoices

    assert_instance_of Array, pending_merchants
    assert_instance_of Merchant, pending_merchants[0]
    assert pending_merchants.all? {|merchant| merchant.invoices.any?
                                      {|invoice| invoice.status == "pending"}}
  end


end
