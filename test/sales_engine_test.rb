require './test/test_helper'

class SalesEngineTest < Minitest::Test
  def test_master_test
    skip
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
    })
    assert_equal MerchantRepository, se.merchants.class
    assert_equal ItemRepository, se.items.class
  end
end
