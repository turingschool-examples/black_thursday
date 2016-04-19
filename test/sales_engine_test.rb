require './test/test_helper'
require './lib/sales_engine'

class SalesEngineTest < Minitest::Test

  def setup
    @s = SalesEngine.from_csv({
      :items => "./data/items.csv",
      :merchants => "./data/merchants.csv"})
  end

  def test_it_created_instance_of_sales_engine_class
    assert_equal false, @s.empty?
  end


end
