require 'test_helper'

class SalesAnalystTest < Minitest::Test

  def setup
    sales_engine = SalesEngine.from_csv({:items => './test/fixtures/items.csv',
                                        :merchants => './test/fixtures/merchants.csv',
                                        :invoices => './test/fixtures/invoices.csv'})
    @sales_analyst = SalesAnalyst.new(sales_engine)
  end


  def test_that_we_find_average_items_per_merchant
    assert_equal @sales_analyst.sales_engine.merchants.merchants, @sales_analyst.sales_engine.merchants.all
  end

  

end
