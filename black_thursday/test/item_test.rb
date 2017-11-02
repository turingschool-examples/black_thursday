require_relative 'test_helper'
require 'bigdecimal'
require 'time'
require_relative './../lib/item'
require_relative './../lib/sales_engine'

class ItemTest < Minitest::Test
  attr_reader :repository,
              :engine

  def setup
    @engine = SalesEngine.from_csv(
      items: "./test/fixtures/truncated_items.csv",
      merchants: "./test/fixtures/truncated_merchants.csv"
    )

    @repository = ItemRepository.new("./test/fixtures/truncated_items.csv", engine)
  end

  def test_it_exists
    created_at = "2016-01-11 09:34:06 UTC"
    updated_at = "2017-06-04 21:35:10 UTC"

    item = Item.new(
      {id: "4",
      name: "pencil",
      description: "You can use it to write things",
      unit_price: "1200",
      merchant_id: "10",
      created_at: created_at,
      updated_at: updated_at},
      repository
    )

    assert_instance_of Item, item
  end

  def test_it_can_hold_attributes
    created_at = "2016-01-11 09:34:06 UTC"
    updated_at = "2017-06-04 21:35:10 UTC"

    item = Item.new(
      {id: "4",
      name: "pencil",
      description: "You can use it to write things",
      unit_price: "1200",
      merchant_id: "10",
      created_at: created_at,
      updated_at: updated_at},
      repository
    )

    assert_equal 4, item.id
    assert_equal "pencil", item.name
    assert_equal "You can use it to write things", item.description
    assert_equal 12.00, item.unit_price
    assert_equal 10, item.merchant_id
    assert_equal Time.parse("2016-01-11 09:34:06 UTC"), item.created_at
    assert_equal Time.parse("2017-06-04 21:35:10 UTC"), item.updated_at
  end

  def test_it_knows_its_merchant
    created_at = "2016-01-11 09:34:06 UTC"
    updated_at = "2017-06-04 21:35:10 UTC"

    item = Item.new(
      {id: "4",
      name: "pencil",
      description: "You can use it to write things",
      unit_price: "1200",
      merchant_id: "12334135",
      created_at: created_at,
      updated_at: updated_at},
      repository
    )

    assert_equal "GoldenRayPress", item.merchant.name
  end

  def test_can_change_unit_price_to_dollars
    created_at = "2016-01-11 09:34:06 UTC"
    updated_at = "2017-06-04 21:35:10 UTC"

    item = Item.new(
      {id: "4",
      name: "pencil",
      description: "You can use it to write things",
      unit_price: "1200",
      merchant_id: "10",
      created_at: created_at,
      updated_at: updated_at},
      repository
    )

    assert_equal 12.00, item.unit_price_to_dollars
  end
end
