require_relative 'test_helper'
require_relative '../lib/sales_analyst'

class SalesAnalystTest < Minitest::Test
  attr_reader :sa

  def setup
    se = SalesEngine.from_csv({items: "./sa_fixtures/items.csv",
                           merchants: "./sa_fixtures/merchants.csv",
                            invoices: "./sa_fixtures/invoices.csv"
                             })
    @sa = SalesAnalyst.new(se)
  end

  def test_it_exists
    assert_instance_of SalesAnalyst, sa
  end
end
