require './test/test_helper'
require './lib/sales_analyst'
require './lib/sales_engine'



class SalesAnalystTest < Minitest::Test

  def test_setup
    assert SalesAnalyst.new.class
  end
end
