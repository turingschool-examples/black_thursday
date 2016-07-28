require 'bigdecimal'
require './test/test_helper'
require './lib/item'
require './lib/merchant'
require "./lib/item_repo"
require "./lib/sales_engine"

class ItemTest < Minitest::Test
  def setup
    @item = Item.new({  id: 1,
      name: "Pencil",
      description: "You can use it to write things",
      unit_price: "1099",
      created_at: "2016-07-26 13:59:43 -0600",
      updated_at: "2016-07-26 13:59:43 -0600",
      merchant_id: 1
 },
    ItemRepo.new("./data/items.csv", SalesEngine.new({merchant: "./data/support/merchant_support.csv", items: "./data/items.csv", invoice: "./data/support/invoice_support.csv"})))
  end

  def test_gives_its_id
    assert_equal 1, @item.id
  end

  def test_gives_its_name
    assert_equal "Pencil", @item.name
  end

  def test_gives_its_description
    assert_equal "You can use it to write things", @item.description
  end

  def test_gives_its_price
    assert_equal BigDecimal.new(1099,4), @item.unit_price
  end

  def test_gives_price_as_dollars
    assert_equal 10.99, @item.unit_price_to_dollars
  end

  def test_prices_with_one_decimal_work
    item = Item.new({unit_price: "1100"})
    assert_equal 11.00, item.unit_price_to_dollars
    item = Item.new({unit_price: "1140"})
    assert_equal 11.40, item.unit_price_to_dollars
  end

  def test_gives_time_created
    skip
    time = Time.now
    item = Item.new({  id: 1,
      name: "Pencil",
      description: "You can use it to write things",
      unit_price: "1099",
      created_at: time.to_s,
      updated_at: time.to_s,
      merchant_id: 1})
      assert_equal time, item.created_at
  end

  def test_gives_time_updated
    skip
    time = Time.now
    item = Item.new({  id: 1,
      name: "Pencil",
      description: "You can use it to write things",
      unit_price: "1099",
      created_at: time,
      updated_at: time,
      merchant_id: 1})
      assert_equal time, item.updated_at
  end

  def test_gives_owners_merchant_id
    assert_equal 1, @item.merchant_id
  end

  def test_it_finds_the_merchant_it_belongs_to
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/support/merchant_support.csv",
      })
    se.merchants
    item = Item.new({  id: 1,
      name: "Pencil",
      description: "You can use it to write things",
      unit_price: "1099",
      created_at: time,
      updated_at: time,
      merchant_id: 12334146}, se.items)
    assert_kind_of Merchant, item.merchant
  end

end
