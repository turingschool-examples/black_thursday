require 'bigdecimal'
require './test/test_helper'
require './lib/item'
require './lib/merchant'
require "./lib/item_repo"
require "./lib/sales_engine"

class ItemTest < Minitest::Test
  def test_gives_its_id
    item = Item.new({id: "1"})
    assert_equal 1, item.id
  end

  def test_gives_its_name
    item = Item.new({name: "Pencil"})
    assert_equal "Pencil", item.name
  end

  def test_gives_its_description
    item = Item.new({description: "You can use it to write things"})
    assert_equal "You can use it to write things", item.description
  end

  def test_gives_its_price
    item = Item.new({unit_price: "1099"})
    assert_equal BigDecimal.new(10.99,4), item.unit_price
  end

  def test_gives_price_as_dollars
    item = Item.new({unit_price: "1099"})
    assert_equal 10.99, item.unit_price_to_dollars
  end

  def test_prices_with_one_decimal_work
    item = Item.new({unit_price: "1100"})
    assert_equal 11.00, item.unit_price_to_dollars
    item = Item.new({unit_price: "1140"})
    assert_equal 11.40, item.unit_price_to_dollars
  end

  def test_gives_time_created
    time = "2016-01-11 09:34:06 UTC"
    item = Item.new({created_at: "2016-01-11 09:34:06 UTC"})
    assert_equal time, item.created_at
  end

  def test_gives_time_updated
    time = Time.parse("2016-01-11 09:34:06 UTC")
    item = Item.new({updated_at: "2016-01-11 09:34:06 UTC"})
    assert_equal time, item.updated_at
  end

  def test_gives_owners_merchant_id
    item = Item.new({merchant_id: "1"})
    assert_equal 1, item.merchant_id
  end

  def test_it_finds_the_merchant_it_belongs_to
    mock_ir = Minitest::Mock.new
    mock_ir.expect(:find_merchant_by_id, "instance_of_merchant", [12334146])

    item = Item.new({merchant_id: 12334146}, mock_ir)
    assert_equal "instance_of_merchant", item.merchant
    assert mock_ir.verify
  end
end
