# sa.best_invoice_by_revenue #=> invoice
#
# sa.best_invoice_by_quantity #=> invoice


require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/sales_analyst'

class MarketAnalyticsTest < Minitest::Test

  def test_include
    skip
    sales_engine = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoices => "./data/invoices.csv",
      :invoice_items => "./data/invoice_items.csv",
      :transactions => "./data/transactions.csv"
    })
    sales_analyst = SalesAnalyst.new(sales_engine)

    refute_equal nil, sales_analyst.invoice_items
    refute_equal nil, sales_analyst.transactions
    refute_equal nil, sales_analyst.total_revenue_by_date(Time.new(2013, 12, 20))
  end

  def test_total_revenue_by_date
    skip
    sales_engine = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoices => "./data/invoices.csv",
      :invoice_items => "./data/invoice_items.csv",
      :transactions => "./data/transactions.csv"
    })
    sales_analyst = SalesAnalyst.new(sales_engine)

    date = Time.new(2001, 10, 23)
    total_revenue = sales_analyst.total_revenue_by_date(date)

    assert_equal 1, total_revenue
  end

  def test_revenue_by_merchant
    skip
    sales_engine = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoices => "./data/invoices.csv",
      :invoice_items => "./data/invoice_items.csv",
      :transactions => "./data/transactions.csv"
    })
    sales_analyst = SalesAnalyst.new(sales_engine)

    merchant_id_1 = 12334228
    merchant_id_2 = 12334832
    revenue_1 = sales_analyst.revenue_by_merchant(12334228)
    revenue_2 = sales_analyst.revenue_by_merchant(12334832)

    assert_equal 1, revenue_1
    assert_equal 2, revenue_2
  end

  def test_top_revenue_earners_default
    skip
    sales_engine = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoices => "./data/invoices.csv",
      :invoice_items => "./data/invoice_items.csv",
      :transactions => "./data/transactions.csv"
    })
    sales_analyst = SalesAnalyst.new(sales_engine)

    top_earners = sales_analyst.top_revenue_earners

    assert_instance_of Array, top_earners
    assert_instance_of Merchant, top_earners[0]
    assert_equal 20, top_earners.length
  end

  def test_top_revenue_earners_with_argument
    skip
    sales_engine = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoices => "./data/invoices.csv",
      :invoice_items => "./data/invoice_items.csv",
      :transactions => "./data/transactions.csv"
    })
    sales_analyst = SalesAnalyst.new(sales_engine)

    top_five = sales_analyst.top_revenue_earners(5)

    assert_instance_of Array, top_earners
    assert_instance_of Merchant, top_earners[0]
    assert_equal 5, top_earners.length
  end

  def test_most_sold_item_for_merchant
    sales_engine = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoices => "./data/invoices.csv",
      :invoice_items => "./data/invoice_items.csv",
      :transactions => "./data/transactions.csv"
    })
    sales_analyst = SalesAnalyst.new(sales_engine)

    merchant_id_1 = 12334228
    merchant_id_2 = 12334832
    item_1 = sales_analyst.most_sold_item_for_merchant(12334228)
    item_2 = sales_analyst.most_sold_item_for_merchant(12334832)

    assert_instance_of Array, item_1
    assert_instance_of Item, item_1[0]
    assert_instance_of Array, item_2
    assert_instance_of Item, item_2[0]
  end

  def test_best_item_for_merchant
    sales_engine = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoices => "./data/invoices.csv",
      :invoice_items => "./data/invoice_items.csv",
      :transactions => "./data/transactions.csv"
    })
    sales_analyst = SalesAnalyst.new(sales_engine)


    merchant_id_1 = 12334228
    merchant_id_2 = 12334832
    item_1 = sales_analyst.best_item_for_merchant(12334228)
    item_2 = sales_analyst.best_item_for_merchant(12334832)

    assert_instance_of Array, item_1
    assert_instance_of Item, item_1[0]
    assert_instance_of Array, item_2
    assert_instance_of Item, item_2[0]
  end

end
