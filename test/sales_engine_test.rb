require_relative './test_helper'
require './lib/sales_engine'
require './lib/merchant_repository'
require './lib/item_repository'
require './lib/merchant'
require './lib/item'


class SalesEngineTest < Minitest::Test

  def setup
    @se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      })
  end

  def test_it_exists_and_has_attribute
    assert_instance_of SalesEngine, @se
  end
end
