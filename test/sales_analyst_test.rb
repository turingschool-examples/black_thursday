require './test/test_helper'
require './lib/sales_analyst'


class SalesAnalystTest < Minitest::Test
  attr_reader :se,
              :sa

  def setup
    @se = SalesEngine.from_csv({
  :items     => "./data/items.csv",
  :merchants => "./data/merchants.csv",
  })
  @sa = SalesAnalyst.new(se)
  end

  def test_it_exists
    assert @sa
  end

end
