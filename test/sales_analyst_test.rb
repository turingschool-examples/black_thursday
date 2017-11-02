require_relative 'test_helper'

class SalesAnalystTest < Minitest::Test

  def setup
    sales_engine = SalesEngine.from_csv({:items => './test/fixtures/items_fixture.csv',
                                        :merchants => './test/fixtures/merchants.csv',
                                        :invoices => './test/fixtures/invoices.csv'})
    @sales_analyst = SalesAnalyst.new(sales_engine)
  end


  def test_that_we_find_average_items_per_merchant
    assert_equal 2.33, @sales_analyst.average_items_per_merchant
  end

  

end
