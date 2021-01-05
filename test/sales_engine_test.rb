require 'Minitest/autorun'
require 'Minitest/pride'
require './lib/sales_engine'

class SalesEngineTest < Minitest::Test
  def setup
    @se = SalesEngine.from_csv({
                              items:     "./data/items.csv",
                              merchants: "./data/merchants.csv",
                              })
  end

  def test_it_exist_with_attributes
    assert_instance_of SalesEngine, @se
  end

  # def test_it_has_readable_attributes
  #   assert_equal "./data/items.csv", @se.items
  #   assert_equal "./data/merchants.csv", @se.merchants
  # end

  def test_sales_engine_can_build_merchant_repo

    assert_equal 475, @se.merchants.count
  end
end
