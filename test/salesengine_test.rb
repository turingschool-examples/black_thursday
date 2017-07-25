require './lib/sales_engine'
require './lib/item_repository'
require './lib/merchant_repository'
require 'minitest/autorun'
require 'minitest/pride'
require 'pry'


class SalesEngineTest < Minitest::Test

  def test_load_item_from_item_csv
    se = SalesEngine.new
    se.from_csv({
    :items     => "./data/items.csv",
    :merchants => "./data/merchants.csv",
    })

    assert_instance_of ItemRepository, se.items
  end

  def test_load_merchants_from_merchant_csv
    se = SalesEngine.new
    se.from_csv({
    :items     => "./data/items.csv",
    :merchants => "./data/merchants.csv",
    })

    assert_instance_of MerchantRepository, se.merchants
  end
end
