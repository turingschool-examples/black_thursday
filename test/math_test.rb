require_relative 'test_helper'
require_relative '../lib/sales_engine'
require_relative '../lib/sales_analyst'

class MathTest < Minitest::Test
  def setup
    files = ({:items => "./test/fixture/item_fixture.csv",
              :merchants => "./test/fixture/merchant_fixture.csv"})
    @se = SalesEngine.from_csv(files)
    @sa = SalesAnalyst.new(se)
  end

  def 


end
