require './test/test_helper'
require './lib/item_repo'

class ItemRepoTest < Minitest::Test
  def test_all
    ir = ItemRepo.new('./data/items.csv')
    assert_equal 1367, ir.items.count
  end

  def test_find_by_id
    id  = 263395237
    ir = ItemRepo.new('./data/items.csv')
    item = ir.find_by_id(id)
    assert_equal id, item.id

    assert_equal nil, ir.find_by_id(1)
  end

  def test_find_by_name
    name = "510+ RealPush Icon Set"
    ir = ItemRepo.new('./data/support/items_support.csv')
    item = ir.find_by_name(name)
    assert_equal name, item.name

    assert_equal nil, ir.find_by_name("")
  end

  def test_find_all_with_description
    description = "fancy"
    ir = ItemRepo.new('./data/support/items_support.csv')
    matches = ir.find_all_with_description(description)
    assert_equal 1, matches.count

    assert_equal [], ir.find_all_with_description("butts")
  end

  def test_find_by_price
    price = 12.00
    ir = ItemRepo.new('./data/items.csv')
    matches = ir.find_all_by_price(price)
    assert_equal 41, matches.count
    assert_equal [], ir.find_all_by_price(999999999999999)
  end

  def test_find_by_price_range
    price_range = (10.0..100.0)
    ir = ItemRepo.new('./data/items.csv')
    matches = ir.find_all_by_price_in_range(price_range)
    assert_equal 853, matches.count
    assert_equal [], ir.find_all_by_price_in_range(0.0..0.01)
  end

  def test_find_item_by_merchant_id
    merchant_id = 12334207
    ir = ItemRepo.new('./data/items.csv')
    matches = ir.find_all_by_merchant_id(merchant_id)
    assert_equal 1, matches.count
    assert_equal [], ir.find_all_by_merchant_id(1)
  end

  def test_find_all_items
    ir = ItemRepo.new("./data/support/items_support.csv")
    items = ir.all

    assert_equal 2, items.count
  end

  def find_merchant_by_id
    mock_se = Minitest::Mock.new
    mock_se.expect(:find_merchant_by_id, "instance of merchant", [12334207])

    ir = ItemRepo.new('./data/support/items_support.csv', mock_se)
    assert_equal "instance of merchant", ir.find_merchant_by_id(12334207)
    assert mock_se.verify
  end
end
