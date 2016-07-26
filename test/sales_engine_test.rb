require './test/test_helper'
require './lib/sales_engine'

class SalesEngineTest < Minitest::Test
  def test_from_cvs_method_can_return_hash_argument
    hash = {:a => "value_a", :b => "value_b"}
    se = SalesEngine.from_csv(hash)
    assert_equal hash, se.data
  end

  def test_master_test
    skip
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
    })
    assert_equal ItemRepository, se.items.class
    assert_equal MerchantRepository, se.merchants.class
  end
end
