require_relative '../test/test_helper'
require_relative '../lib/sales_engine'
require_relative '../lib/sales_analyst'
require_relative '../lib/analytics/item_analytics'

class ItemAnalyticsTest < Minitest::Test
  def setup
    # sales_engine = SalesEngine.from_csv(
    #   customers: './test/fixtures/test_customers.csv',
    #   invoices: './test/fixtures/test_invoices.csv',
    #   invoice_items: './test/fixtures/test_invoice_items.csv',
    #   items: './test/fixtures/test_items1.csv',
    #   merchants: './test/fixtures/test_merchants1.csv',
    #   transactions: './test/fixtures/test_transactions.csv'
    # )
    # @sales_analyst = SalesAnalyst.new(sales_engine)
    data = %(id,name,description,unit_price,merchant_id,created_at,updated_at
             1,Item One,This is item one,100,123,2010-10-24,2010-10-24
             2,Item Two,This is item two,2000,456,2011-12-10,2012-10-04
             3,Item Three,This is item three,2100,456,2011-12-10,2012-10-04
             4,Item Four,This is item four,200,456,2011-12-10,2012-10-04
             5,Golden Item,This is a golden item,4400,789,2010-04-08,2010-04-08)
    items_data = CSV.parse(data, headers: :true, header_converters: :symbol)
    attrs = { item_repo: ItemRepository.new(items_data) }
    sales_engine = SalesEngine.new(attrs)
    @sales_analyst = SalesAnalyst.new(sales_engine)
  end

  def test_average_item_price
    assert_equal 7357.66, @sales_analyst.average_item_price.to_f.round(2)
  end

  def test_average_item_price_standard_deviation
    result = @sales_analyst.average_item_price_standard_deviation
    assert_equal 70.71, result
    assert_instance_of Float, result
  end

  def test_golden_items
    result = @sales_analyst.golden_items
    assert_equal ['Test listing'], result.map(&:name)
    assert_instance_of Item, result[0]
  end

  def test_items_bought_in_year
    skip
    sales_engine = SalesEngine.from_csv(
      customers: './test/fixtures/test_customers.csv',
      invoices: './test/fixtures/test_invoices.csv',
      invoice_items: './test/fixtures/test_invoice_items.csv',
      items: './test/fixtures/test_items1.csv',
      merchants: './test/fixtures/test_merchants1.csv',
      transactions: './test/fixtures/test_transactions.csv'
    )
    sales_analyst = SalesAnalyst.new(sales_engine)
    result = sales_analyst.items_bought_in_year(1, 2009)
    assert_instance_of Item, result[0]
    assert_instance_of Item, result[1]
    assert_equal [263519844, 263451719], result.map(&:id)
  end
end
