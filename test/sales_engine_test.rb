require_relative 'test_helper'
require_relative '../lib/sales_engine'

class SalesEngineTest < Minitest::Test
  attr_reader :se

  def setup
    @se = SalesEngine.new({invoices: "./data/invoice_fixtures.csv"})
  end

  def test_it_exists
    assert_instance_of SalesEngine, se
  end
end
