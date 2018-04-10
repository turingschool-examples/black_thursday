require './test/test_helper'
require './lib/sales_engine'
require './lib/item_repository'
require './lib/merchant_repository'

class SalesEngineTest < Minitest::Test
  def test_it_exists
    se = SalesEngine.from_csv({
  :items     => "./data/item.csv",
  :merchants => "./data/merchants.csv"
  })
    assert_instance_of SalesEngine, se
  end

  # def test_it_has_attribute_item
  #   se = SalesEngine.from_csv({
  # :items     => "./data/item.csv",
  # :merchants => "./data/merchants.csv"
  # })
  #   assert_equal "", se.merchants
  # end


end
