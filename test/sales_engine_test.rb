require './test/test_helper'
require "./lib/sales_engine"

class SalesEngineTest < Minitest::Test

  def test_it_exists
    se = SalesEngine.new("./data/items.csv", "./data/merchants.csv")

    assert_instance_of SalesEngine, se
  end

  def test_se_has_an_item_repository
    se = SalesEngine.new("./data/items.csv", "./data/merchants.csv")

    assert se.item_repository
  end
end

class ItemRepositoryTest < Minitest::Test

  def test_it_creates_items
    ir = ItemRepository.new(nil)

    assert_equal 0, ir.count

    ir.create_item(name: "Sample 1")
    ir.create_item(name:  "Sample 2")

    assert_equal 2, ir.count
    assert_equal "Sample 1", ir.items[0].name
    assert_equal "Sample 2", ir.items[1].name
  end
end

class ItemTest < Minitest::Test

  def test_it_knows_where_it_came_from
    item_repository = ItemRepository.new(nil)
    item_repository.create_item(name: "Something")
    item = item_repository.items.first

    assert_equal item_repository, item.repository
  end

  def test_item_can_find_the_associated_merchant
    se = SalesEngine.new("./data/items.csv", "./data/merchants.csv")
    se.merchant_repository.create_merchant(name: "The Merch", id: 24)
    merchant = se.merchant_repository.merchants.first
    se.item_repository.create_item(name: "Thing 3", merchant_id: 24)

  end
end
