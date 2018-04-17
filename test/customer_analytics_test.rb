require_relative '../test/test_helper'
require_relative '../lib/sales_engine'
require_relative '../lib/sales_analyst'
require_relative '../lib/analytics/customer_analytics'

class CustomerAnalyticsTest < Minitest::Test
  def setup
    sales_engine = SalesEngine.from_csv(
      customers: './test/fixtures/test_customers.csv',
      invoices: './test/fixtures/test_invoices.csv',
      invoice_items: './test/fixtures/test_invoice_items.csv',
      items: './test/fixtures/test_items1.csv',
      merchants: './test/fixtures/test_merchants1.csv',
      transactions: './test/fixtures/test_transactions.csv'
    )
    @sales_analyst = SalesAnalyst.new(sales_engine)
  end

  def test_it_grabs_top_buyers
    sales_analyst = new_sales_analyst_5
    result = sales_analyst.top_buyers(3)
    assert_equal 1, result.first.id
    assert_equal 3, result.last.id
    assert_instance_of Customer, result.first
  end

  def test_it_finds_top_merchant_for_customer
    sales_analyst = new_sales_analyst_5
    result = sales_analyst.top_merchant_for_customer(1)
    assert_instance_of Merchant, result
    assert_equal 12335955, result.id
  end

  def test_it_finds_one_time_buyers
    sales_analyst = new_sales_analyst_5
    result = sales_analyst.one_time_buyers
    assert_equal 3, result.length
    assert_instance_of Customer, result.first
    assert_equal [4, 19, 20], result.map(&:id)
  end

  def test_it_finds_one_time_buyers_invoice_items
    sales_analyst = new_sales_analyst_5
    result = sales_analyst.one_time_buyers_invoice_items
    assert_equal 8, result.length
    assert_instance_of InvoiceItem, result.first
  end

  def test_it_finds_one_time_buyers_top_item
    invoices_csv = %(id,customer_id,merchant_id,status,created_at,updated_at
                     1,1,123,shipped,2011-08-08,2011-08-08
                     2,1,124,pending,2013-09-21,2013-09-21
                     3,2x,125,shipped,2014-02-14,2014-02-14
                     4,1,126,returned,2014-02-14,2014-02-14
                     5,3x,126,returned,2014-02-14,2014-02-14
                     6,4x,126,returned,2014-02-14,2014-02-14)
    # invoice_items_csv = %(id,item_id,invoice_id,quantity,unit_price,created_at,updated_at
    #                       1,1,3,4,100,2011-08-08,2011-08-08
    #                       2,2,3,1,200,2012-04-03,2012-04-03
    #                       3,3,1,4,800,2012-04-12,2012-04-12
    #                       4,4,1,1,200,2012-03-21,2012-03-21
    #                       5,5,6,1,200,2012-03-21,2012-03-21
    #                       6,2,5,1,200,2012-03-21,2012-03-21)
    invoice_items_csv = %(id,item_id,invoice_id,quantity,unit_price,created_at,updated_at
                          1,3601,3,4,100,2011-08-08,2011-08-08
                          2,1234,3,1,200,2012-04-03,2012-04-03
                          3,3600,1,4,800,2012-04-12,2012-04-12
                          6,1234,5,1,200,2012-03-21,2012-03-21
                          5,2347,6,1,200,2012-03-21,2012-03-21)
    items_csv = %(id,name,description,unit_price,merchant_id,created_at,updated_at
      3600,Item One,This is item one,100,123,2010-10-24,2010-10-24
      3601,Item Two,This is item two,200,456,2011-12-10,2012-10-04
      1234,Item Three,This is item three,800,456,2011-12-10,2012-10-04
      2347,Item Four,This is item four,200,456,2011-12-10,2012-10-04)
    invoice_items_data = parse_data(invoice_items_csv)
    items_data = parse_data(items_csv)
    invoice_data = parse_data(invoices_csv)
    attrs = { item_repo: ItemRepository.new(items_data), invoice_item_repo: InvoiceItemRepository.new(invoice_items_data),
    invoice_repo: InvoiceRepository.new(invoice_data)}
    sales_engine = SalesEngine.new(attrs)
    sales_analyst = sales_engine.analyst
    # require 'pry';binding.pry
    the_item = attrs[:item_repo].items[1234]
    assert_equal [the_item], sales_analyst.one_time_buyers_top_item
    # sales_analyst = new_sales_analyst_5
    # result = sales_analyst.one_time_buyers_top_item
    # assert_equal 263396463, result.id
    # assert_instance_of Item, result
  end

  def test_customers_with_unpaid_invoices
    sales_analyst = new_sales_analyst_5
    result = sales_analyst.customers_with_unpaid_invoices
    assert_instance_of Customer, result.first
    assert_equal 25, result.length
  end

  def new_sales_analyst_5
    sales_engine = SalesEngine.from_csv(
      customers: './test/fixtures/test_customers5.csv',
      invoices: './test/fixtures/test_invoices5.csv',
      invoice_items: './test/fixtures/test_invoice_items5.csv',
      items: './test/fixtures/test_items5.csv',
      merchants: './test/fixtures/test_merchants2.csv',
      transactions: './test/fixtures/test_transactions5.csv'
    )
    sales_engine.analyst
  end

  def parse_data(csv)
   CSV.parse(csv, headers: :true, header_converters: :symbol)
  end
end
