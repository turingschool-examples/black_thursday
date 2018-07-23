require './test/test_helper.rb'
require './lib/sales_analyst.rb'

class SalesAnalystTest < Minitest::Test
  def setup
    sales_engine = SalesEngine.from_csv(
      items: './data/items.csv',
      merchants: './data/merchants.csv',
      invoices: './data/invoices_test.csv',
      customers: './data/customers.csv',
      invoice_items: './data/invoice_items_test.csv',
      transactions: './data/transactions_test.csv'
    )
    @sales_analyst = SalesAnalyst.new(sales_engine)
  end

  def test_it_exists
    assert_instance_of SalesAnalyst, @sales_analyst
  end

  def test_average_items_per_merchant
    assert_equal 2.88, @sales_analyst.average_items_per_merchant
  end

  def test_average_items_per_merchant_standard_deviation
    assert_equal 3.26, @sales_analyst.average_items_per_merchant_standard_deviation
  end

  def test_merchants_with_high_item_count
    assert_equal 52, @sales_analyst.merchants_with_high_item_count.count
    assert_instance_of Merchant, @sales_analyst.merchants_with_high_item_count.first
  end


end
