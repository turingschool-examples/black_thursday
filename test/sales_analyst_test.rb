require_relative 'test_helper'
require_relative '../lib/sales_analyst.rb'

class SalesAnalystTest < Minitest::Test

  def setup
    @sales_engine = SalesEngine.from_csv({:merchants => "./data/merchants_tiny.csv"})
    @sales_analyst = sales_engine.analyst
    require "pry"; binding.pry
  end



end
