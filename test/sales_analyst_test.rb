# sa.total_revenue_by_date(date) #=> $$
# sa.top_revenue_earners(x) #=> [merchant, merchant, merchant, merchant, merchant]
#         ^top x merchants
# sa.top_revenue_earners #=> [merchant * 20]
#      ^20 merchants by default
# sa.merchants_with_pending_invoices #=> [merchant, merchant, merchant]
# sa.merchants_with_only_one_item #=> [merchant, merchant, merchant]
# sa.merchants_with_only_one_item_registered_in_month("Month name") #=> [merchant, merchant, merchant]
# sa.revenue_by_merchant(merchant_id) #=> $
# sa.most_sold_item_for_merchant(merchant_id) #=> [item] (in terms of quantity sold) or, if there is a tie, [item, item, item]
# sa.best_item_for_merchant(merchant_id) #=> item (in terms of revenue generated)

require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/sales_analyst'

class SalesAnalystTest < Minitest::Test
  def test_average_items_per_merchant
    sales_engine = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoices => "./data/invoices.csv"
    })
    sales_analyst = SalesAnalyst.new(sales_engine)

    average_items = sales_analyst.average_items_per_merchant

    assert_equal 2.88, average_items
  end

  def test_average_items_per_merchant_standard_deviation
    sales_engine = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoices => "./data/invoices.csv"
    })
    sales_analyst = SalesAnalyst.new(sales_engine)

    standard_deviation = sales_analyst.average_items_per_merchant_standard_deviation

    assert_equal 3.26, standard_deviation
  end

  def test_merchants_with_high_item_count
    sales_engine = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoices => "./data/invoices.csv"
    })
    sales_analyst = SalesAnalyst.new(sales_engine)

    high_item_merchants = sales_analyst.merchants_with_high_item_count

    assert_instance_of Array, high_item_merchants
    assert_instance_of Merchant, high_item_merchants[0]
  end

  def test_average_item_price_for_merchant
    sales_engine = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoices => "./data/invoices.csv"
    })
    sales_analyst = SalesAnalyst.new(sales_engine)
    merchant_id = 12334105

    average_item_price = sales_analyst.average_item_price_for_merchant(12334105)
    assert_equal 16.66, average_item_price
  end

  def test_average_price_per_merchant
    sales_engine = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoices => "./data/invoices.csv"
    })
    sales_analyst = SalesAnalyst.new(sales_engine)

    average_price = sales_analyst.average_price_per_merchant

    assert_equal 252.53, average_price
  end

  def test_golden_items
    sales_engine = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoices => "./data/invoices.csv"
    })
    sales_analyst = SalesAnalyst.new(sales_engine)

    golden_items = sales_analyst.golden_items

    assert_instance_of Array, golden_items
    assert_instance_of Item, golden_items[0]
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

  def test_convert_date_to_day
    sales_engine = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoices => "./data/invoices.csv"
    })
    sales_analyst = SalesAnalyst.new(sales_engine)

    assert_equal :Friday, sales_analyst.convert_date_to_day(Time.new(2017, 07, 28))
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

  def test_total_revenue_by_date
    sales_engine = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoices => "./data/invoices.csv"
    })
    sales_analyst = SalesAnalyst.new(sales_engine)

    date = Time.new(2001, 10, 23)
    total_revenue = sales_engine.total_revenue_by_date(date)

    asseert total_revenue > 1
  end

  def test_top_revenue_earners_default
    sales_engine = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoices => "./data/invoices.csv"
    })
    sales_analyst = SalesAnalyst.new(sales_engine)

    top_earners = sales_analyst.top_revenue_earners

    assert_instance_of Array, top_earners
    assert_instance_of Merchant, top_earners[0]
    assert_equal 20, top_earners.length
  end

  def test_top_revenue_earners_with_argument
    sales_engine = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoices => "./data/invoices.csv"
    })
    sales_analyst = SalesAnalyst.new(sales_engine)

    top_five = sales_analyst.top_revenue_earners(5)

    assert_instance_of Array, top_earners
    assert_instance_of Merchant, top_earners[0]
    assert_equal 5, top_earners.length
  end

end
