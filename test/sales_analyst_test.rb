require_relative '../lib/sales_analyst'
require_relative '../lib/sales_engine'
require_relative 'test_helper'
require 'pry'

class SalesAnalystTest < Minitest::Test
  def setup
    @se = SalesEngine.from_csv(items: './test/fixtures/items.csv',
                               merchants: './test/fixtures/merchants.csv')
    @sales_analyst = SalesAnalyst.new(@se)
  end

  def tets_it_exists
    assert_instance_of SalesAnalyst, @sales_analyst
    assert_instance_of @se, @sales_analyst.sales_engine.downcase
  end
end
