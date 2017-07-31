# # invoice.transactions.map(&:result) #=> ["failed", "success"]
# invoice.is_paid_in_full? #=> true
#
# # invoice.transactions.map(&:result) #=> ["failed", "failed"]
# invoice.is_paid_in_full? #=> false
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/sales_analyst'
require 'pry'

class SalesAnalystTest < Minitest::Test
  def test_average_items_per_merchant
    sales_engine = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv"
    })
    sales_analyst = SalesAnalyst.new(sales_engine)

    average_items = sales_analyst.average_items_per_merchant

    assert_equal 2.88, average_items
  end

  def test_average_items_per_merchant_standard_deviation
    sales_engine = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv"
    })
    sales_analyst = SalesAnalyst.new(sales_engine)

    standard_deviation = sales_analyst.average_items_per_merchant_standard_deviation

    assert_equal 3.26, standard_deviation
  end

  def test_merchants_with_high_item_count
    sales_engine = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv"
    })
    sales_analyst = SalesAnalyst.new(sales_engine)

    high_item_merchants = sales_analyst.merchants_with_high_item_count

    assert_instance_of Array, high_item_merchants
    assert_instance_of Merchant, high_item_merchants[0]
  end

  def test_average_item_price_for_merchant
    sales_engine = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv"
    })
    sales_analyst = SalesAnalyst.new(sales_engine)
    merchant_id = 12334105

    average_item_price = sales_analyst.average_item_price_for_merchant(12334105)
    assert_equal 16.66, average_item_price
  end

  def test_average_price_for_merchant
    sales_engine = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv"
    })
    sales_analyst = SalesAnalyst.new(sales_engine)

    average_price = sales_analyst.average_price_for_merchant(12334144)

    assert_instance_of BigDecimal, average_price
  end

  def test_average_average_price_for_merchant
    sales_engine = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv"
    })
    sales_analyst = SalesAnalyst.new(sales_engine)

    average_price = sales_analyst.average_average_price_for_merchant

    assert_equal 252.53, average_price
  end

  def test_golden_items
    sales_engine = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv"
    })
    sales_analyst = SalesAnalyst.new(sales_engine)

    golden_items = sales_analyst.golden_items

    assert_instance_of Array, golden_items
    assert_instance_of Item, golden_items[0]
  end

  def test_merchants_with_only_one_item
    sales_engine = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv"
    })
    sales_analyst = SalesAnalyst.new(sales_engine)

    lonely_merchants = sales_analyst.merchants_with_only_one_item

    assert_instance_of Array, lonely_merchants
    assert_instance_of Merchant, lonely_merchants[0]
    assert lonely_merchants.all? {|merchant| merchant.items.count == 1}
  end

  def test_merchants_with_only_one_item_registered_in_month
    sales_engine = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv"
    })
    sales_analyst = SalesAnalyst.new(sales_engine)

    month = "January"
    lonely_merchants = sales_analyst.merchants_with_only_one_item_registered_in_month(month)

    assert_instance_of Array, lonely_merchants
    assert_instance_of Merchant, lonely_merchants[0]
    assert lonely_merchants.all? {|merchant| merchant.items.count == 1}
    assert lonely_merchants.all? {|merchant| merchant.items[0].created_at.month == 1}
  end

end
