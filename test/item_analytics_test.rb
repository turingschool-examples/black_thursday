require_relative 'test_helper'
require_relative '../lib/sales_engine'
require_relative '../lib/sales_analyst'
require_relative '../lib/analytics/item_analytics'

# Items Analytics Test
class ItemAnalyticsTest < Minitest::Test
  def setup
    items_data = parse_data(items)
    invoices_data = parse_data(invoices)
    invoice_items_data = parse_data(invoice_items)
    attrs = { item_repo: ItemRepository.new(items_data),
              invoice_item_repo: InvoiceItemRepository.new(invoice_items_data),
              invoice_repo: InvoiceRepository.new(invoices_data) }
    sales_engine = SalesEngine.new(attrs)
    @sales_analyst = SalesAnalyst.new(sales_engine)
    @item1 = attrs[:item_repo].items[1]
    @item2 = attrs[:item_repo].items[2]
    @item3 = attrs[:item_repo].items[3]
    @item4 = attrs[:item_repo].items[4]
    @item5 = attrs[:item_repo].items[5]
    @item6 = attrs[:item_repo].items[6]
  end

  def test_average_item_price
    assert_equal 11.17, @sales_analyst.average_item_price.to_f.round(2)
  end

  def test_average_item_price_standard_deviation
    result = @sales_analyst.average_item_price_standard_deviation
    assert_equal 20.66, result
    assert_instance_of Float, result
  end

  def test_golden_items
    assert_equal [@item6], @sales_analyst.golden_items
  end

  def test_items_bought_in_year
    sales_analyst = real_data
    result = sales_analyst.items_bought_in_year(400, 2002)
    assert_instance_of Array, result
    assert_equal 2, result.length
    assert_equal 263549742, result.first.id
    assert_equal 'Necklace: V Tube', result.first.name
    assert_instance_of Item, result.first
  end

  def test_highest_volume_items
    sales_analyst = new_sales_analyst_5a
    assert_instance_of Item, sales_analyst.highest_volume_items(1).first
  end

  def real_data
    sales_engine = SalesEngine.from_csv(
      customers: './data/customers.csv',
      invoices: './data/invoices.csv',
      invoice_items: './data/invoice_items.csv',
      items: './data/items.csv',
      merchants: './data/merchants.csv',
      transactions: './data/transactions.csv'
    )
    sales_engine.analyst
  end

  def items
    %(id,name,description,unit_price,merchant_id,created_at,updated_at
      1,Item One,This is item one,100,123,2010-10-24,2010-10-24
      2,Item Two,This is item two,200,456,2011-12-10,2012-10-04
      3,Item Three,This is item three,800,456,2011-12-10,2012-10-04
      4,Item Four,This is item four,200,456,2011-12-10,2012-10-04
      5,Item Five,This is item five,100,456,2011-12-10,2012-10-04
      6,Golden Item,This is a golden item,5300,789,2010-04-08,2010-04-08)
  end

  def invoices
    %(id,customer_id,merchant_id,status,created_at,updated_at
      1,1,123,shipped,2011-08-08,2011-08-08
      2,1,124,pending,2013-09-21,2013-09-21
      3,2,125,shipped,2014-02-14,2014-02-14
      4,1,126,returned,2014-02-14,2014-02-14)
  end

  def invoice_items
    %(id,item_id,invoice_id,quantity,unit_price,created_at,updated_at
      1,1,123,4,100,2011-08-08,2011-08-08
      2,2,124,1,200,2012-04-03,2012-04-03
      3,3,125,4,800,2012-04-12,2012-04-12
      4,4,126,1,200,2012-03-21,2012-03-21)
  end

  def new_sales_analyst_5a
    sales_engine = SalesEngine.from_csv(
      customers: './test/fixtures/test_customers5.csv',
      invoices: './test/fixtures/test_invoices5.csv',
      invoice_items: './test/fixtures/test_invoice_items5.csv',
      items: './test/fixtures/test_items5a.csv',
      merchants: './test/fixtures/test_merchants2.csv',
      transactions: './test/fixtures/test_transactions5.csv'
    )
    sales_engine.analyst
  end

  def parse_data(data)
    CSV.parse(data, headers: :true, header_converters: :symbol)
  end
end
