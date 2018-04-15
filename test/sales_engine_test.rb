require_relative 'test_helper'
require 'csv'
require_relative '../lib/sales_engine'

class SalesEngineTest<Minitest::Test

  def test_it_exists
    se = SalesEngine.new({:items=> "./data/items.csv",:merchants => "./data/merchants.csv"})
    assert_instance_of SalesEngine, se
  end

  def test_it_can_create_sales_analyst
    se = SalesEngine.new({:items=> "./data/items.csv",:merchants => "./data/merchants.csv"})
    sales_analyst = se.analyst

    assert_instance_of SalesAnalyst, sales_analyst
  end


end
