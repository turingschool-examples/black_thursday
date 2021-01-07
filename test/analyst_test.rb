# require './test/test_helper'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/sales_engine'
require './lib/analyst'
require 'CSV'

class AnalystTest < Minitest::Test

  def setup
    data = {
            :items     => "./dummy_data/dummy_items.csv",
            :merchants => "./dummy_data/dummy_merchants.csv"
            #Add CSV dummy files
            }
    sales_engine = SalesEngine.new(data)
    @sales_analyst = sales_engine.analyst
  end

  def test_it_exists
    assert_instance_of Analyst, @sales_analyst
  end


end
