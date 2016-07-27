gem 'minitest', '~> 5.2'
require 'minitest/autorun'
require 'minitest/pride'
require "./lib/sales_engine"


class SalesEngineTest < MiniTest::Test

  def test_it_can_load_a_csv
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
    })
  assert_equal true, se.merchants.is_a?(MerchantRepository)
  assert_equal false, se.merchants.is_a?(ItemRepository)
  assert_equal true, se.items.is_a?(ItemRepository)
  end


end
