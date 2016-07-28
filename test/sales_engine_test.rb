gem 'minitest', '~> 5.2'
require 'minitest/autorun'
require 'minitest/pride'
require "./lib/sales_engine"


class SalesEngineTest < MiniTest::Test
  def setup
    @se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
    })
  end

  def test_the_it_makes_merchant_repositories

  assert_equal true, @se.merchants.is_a?(MerchantRepository)
  assert_equal false, @se.merchants.is_a?(ItemRepository)

  end

  def test_the_it_makes_item_repositories

  assert_equal false, @se.items.is_a?(MerchantRepository)
  assert_equal true, @se.items.is_a?(ItemRepository)

  end
end
