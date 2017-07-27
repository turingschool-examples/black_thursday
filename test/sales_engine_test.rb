require_relative 'test_helper'
require_relative '../lib/sales_engine'

class SalesEngineTest < Minitest::Test
  attr_reader :se

  def setup
    @se = SalesEngine.from_csv({items: "./data/item_fixtures.csv",
                            merchants: "./data/merchant_fixtures.csv",
                             invoices: "./data/invoice_fixtures.csv"})
  end

  def test_it_exists
    assert_instance_of SalesEngine, se
  end
end
