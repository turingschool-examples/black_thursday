require './test/test_helper'
require './lib/sales_engine'

class SalesEngineTest < Minitest::Test
  def test_it_can_initialize_with_IR_and_MR_instances
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
    })
    assert_equal ItemRepository, se.items.class
    assert_equal MerchantRepository, se.merchants.class
  end
end
