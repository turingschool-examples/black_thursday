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

  def test_sales_engine_can_build_merchant_repo

    assert_equal MerchantRepository, @se.merchants.class
    assert_equal ItemRepository, @se.items.class
  end
end
