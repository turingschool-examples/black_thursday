require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/item'
require_relative '../lib/sales_engine'

class ItemTest < Minitest::Test
  def test_initialize
    file_path = "./data/items.csv"
    salesengine = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
    })
    itemrepo = ItemRepository.new(file_path, salesengine)
    item = Item.new({id: 1,
                     name: "salad man",
                     description: "fo yo needs",
                     unit_price: 100000,
                     merchant_id: 32223,
                     created_at: "2016-01-11 11:51:37 UTC",
                     updated_at: "1993-09-29 11:56:40 UTC"}, itemrepo)

    assert_equal 1, item.id
    assert_equal "salad man", item.name
    assert_equal "fo yo needs", item.description
    assert_equal 100000, item.unit_price
    assert_equal 32223, item.merchant_id
    assert_equal "2016-01-11 11:51:37 UTC", item.created_at
    assert_equal "1993-09-29 11:56:40 UTC", item.updated_at
  end

  def test_find_merchant
    file_path = "./data/items.csv"
    salesengine = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
    })
    itemrepo = ItemRepository.new(file_path, salesengine)
    item = Item.new({id: 1,
                     name: "salad man",
                     description: "fo yo needs",
                     unit_price: "100000",
                     merchant_id: "12334271",
                     created_at: "2016-01-11 11:51:37 UTC",
                     updated_at: "1993-09-29 11:56:40 UTC"}, itemrepo)

    assert_instance_of Merchant, item.merchant
  end
end
