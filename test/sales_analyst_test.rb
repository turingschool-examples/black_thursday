require './test/test_helper'
require './lib/sales_engine'
require './lib/sales_analyst'


class SalesAnalystTest < Minitest::Test

  def test_setup
    assert SalesAnalyst.new.class
  end
end
