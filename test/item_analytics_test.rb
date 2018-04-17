require_relative '../test/test_helper'
require_relative '../lib/sales_engine'
require_relative '../lib/sales_analyst'
require_relative '../lib/analytics/item_analytics'

class ItemAnalyticsTest < Minitest::Test
  def setup
    items_data = parse_data(items_csv)
    invoices_data = parse_data(invoices_csv)
    invoice_items_data = parse_data(invoice_items_csv)
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
    assert_equal [@item1], @sales_analyst.items_bought_in_year(1, 2011)
  end

  def items_csv
    %(id,name,description,unit_price,merchant_id,created_at,updated_at
      1,Item One,This is item one,100,123,2010-10-24,2010-10-24
      2,Item Two,This is item two,200,456,2011-12-10,2012-10-04
      3,Item Three,This is item three,800,456,2011-12-10,2012-10-04
      4,Item Four,This is item four,200,456,2011-12-10,2012-10-04
      5,Item Five,This is item five,100,456,2011-12-10,2012-10-04
      6,Golden Item,This is a golden item,5300,789,2010-04-08,2010-04-08)
  end

  def invoices_csv
    %(id,customer_id,merchant_id,status,created_at,updated_at
      1,1,123,shipped,2011-08-08,2011-08-08
      2,1,124,pending,2013-09-21,2013-09-21
      3,2,125,shipped,2014-02-14,2014-02-14
      4,1,126,returned,2014-02-14,2014-02-14)
  end

  def invoice_items_csv
    %(id,item_id,invoice_id,quantity,unit_price,created_at,updated_at
      1,1,123,4,100,2011-08-08,2011-08-08
      2,2,124,1,200,2012-04-03,2012-04-03
      3,3,125,4,800,2012-04-12,2012-04-12
      4,4,126,1,200,2012-03-21,2012-03-21)
  end

  def parse_data(csv)
    CSV.parse(csv, headers: :true, header_converters: :symbol)
  end
end
