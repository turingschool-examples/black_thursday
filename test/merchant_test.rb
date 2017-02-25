require 'minitest/autorun'
require 'minitest/emoji'
require 'mocha/mini_test'
require 'minitest/unit'
require './black_thursday/lib/sales_engine'

class MerchantTest < Minitest::Test

  attr_reader :se

  def setup
    @se = SalesEngine.from_csv({
                                 :items     => "./black_thursday/data/items.csv",
                                 :merchants => "./black_thursday/data/merchants.csv",
    })
  end

  def test_it_exists
    assert se
  end

  def test_it_knows_its_items
    skip
    item1 = mock("item")
    item2 = mock("Item")
    se.add_items([item1, item2])
    assert_include
  end

  def test_items_returns_merchants_items
    assert_equal 3, se.merchants.all.first.items.length
  end
end
