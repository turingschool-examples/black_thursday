require_relative 'test_helper'
require_relative '../lib/sales_analyst.rb'

class SalesAnalystTest < Minitest::Test
	attr_reader :sales_analyst

  def setup
    sales_engine = SalesEngine.from_csv({:merchants => "./data/merchants_tiny.csv"})
    sales_analyst = sales_engine.analyst
    @sales_analyst = sales_analyst
  end

  def test_it_exists
    assert_equal SalesAnalyst, sales_analyst
  end

end
