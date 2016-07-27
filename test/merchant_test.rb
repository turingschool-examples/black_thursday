require './test/test_helper'
require './lib/sales_engine'

class MerchantTest < Minitest::Test

  def test_that_it_has_an_id
    merchant = Merchant.new({ id: "123", name: "Bill"})

    assert_equal "123", merchant.id
  end

  def test_that_it_has_a_name
    merchant = Merchant.new({ id: "123", name: "Bill"})

    assert_equal "Bill", merchant.name
  end

  def test_that_an_merchant_points_to_its_items
    se = SalesEngine.from_csv({ items: "./data/item_sample.csv", merchants: "./data/merchants_sample.csv" })
    merchant = se.merchants.find_by_id("12334185")

    assert_equal "Glitter scrabble frames", merchant.items[0].name
  end

end
