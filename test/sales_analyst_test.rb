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


end 
