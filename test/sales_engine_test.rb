gem 'minitest', '~> 5.2'
require 'minitest/autorun'
require 'minitest/pride'
require "./lib/sales_engine"


class SalesEngineTest < MiniTest::Test
  attr_reader :se

  def setup
    @se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
    })
  end

  def test_the_it_makes_merchant_repositories
    assert_equal true, se.merchants.is_a?(MerchantRepository)
    assert_equal false, se.merchants.is_a?(ItemRepository)
  end

  def test_the_it_makes_item_repositories
    assert_equal false, se.items.is_a?(MerchantRepository)
    assert_equal true, se.items.is_a?(ItemRepository)
  end

  def test_it_can_return_instance_of_merchant
    mr = se.merchants
    merchant = mr.find_by_name("sparetimecrocheter")
    assert_instance_of Merchant, merchant
    assert_equal 12335961, merchant.id
  end

  def test_it_can_return_instance_of_item
    ir = se.items
    item = ir.find_by_name("Disney scrabble frames")
    assert_instance_of Item, item
    assert_equal 263395721, item.id
  end
end
