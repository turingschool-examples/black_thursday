require_relative 'test_helper'
require_relative '../lib/sales_analyst'

class SalesAnalystTest < Minitest::Test

  attr_reader :sales_analyst

  def setup
    sales_engine = SalesEngine.from_csv({
      :items => "./test/data_fixtures/items_fixture.csv",
      :merchants => "./test/data_fixtures/merchants_fixture.csv"
    })
    @sales_analyst = SalesAnalyst.new(sales_engine)
  end
  
  def test_sales_analyst_exists
    assert sales_analyst
  end

end