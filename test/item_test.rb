require_relative "../lib/item"
require_relative "test_helper"
require 'bigdecimal'

class ItemTest < Minitest::Test

  def test_it_exists
    item = Item.new({
            :id          => 1,
            :name        => "Pencil",
            :description => "You can use it to write things",
            :merchant_id => 01234567,
            :unit_price  => BigDecimal.new(1099,4),
            :created_at  => Time.now,
            :updated_at  => Time.now
            }, mock("parent"))

    assert_instance_of Item, item
  end

  def test_it_has_id
    parent = mock("parent")
    item = Item.new({
            :id          => 1,
            :name        => "Pencil",
            :description => "You can use it to write things",
            :merchant_id => 01234567,
            :unit_price  => BigDecimal.new(1099,4),
            :created_at  => Time.now,
            :updated_at  => Time.now
            }, parent)

    assert_equal 1, item.id
  end

  def test_it_has_name
    parent = mock("parent")
    item = Item.new({
            :id          => 1,
            :name        => "Pencil",
            :description => "You can use it to write things",
            :merchant_id => 01234567,
            :unit_price  => BigDecimal.new(1099,4),
            :created_at  => Time.now,
            :updated_at  => Time.now
            }, parent)

    assert_equal "Pencil", item.name
  end

  def test_it_has_description
    parent = mock("parent")
    item = Item.new({
            :id          => 1,
            :name        => "Pencil",
            :description => "You can use it to write things",
            :merchant_id => 01234567,
            :unit_price  => BigDecimal.new(1099,4),
            :created_at  => Time.now,
            :updated_at  => Time.now
            }, parent)

    assert_equal "You can use it to write things", item.description
  end

  def test_it_has_merchant_id
    parent = mock("parent")
    item = Item.new({
            :id          => 1,
            :name        => "Pencil",
            :description => "You can use it to write things",
            :merchant_id => 01234567,
            :unit_price  => BigDecimal.new(1099,4),
            :created_at  => Time.now,
            :updated_at  => Time.now
            }, parent)

    assert_equal 01234567, item.merchant_id
  end

  def test_it_has_unit_price
    parent = mock("parent")
    item = Item.new({
            :id          => 1,
            :name        => "Pencil",
            :description => "You can use it to write things",
            :merchant_id => 01234567,
            :unit_price  => BigDecimal.new(1099,4),
            :created_at  => Time.now,
            :updated_at  => Time.now
            }, parent)

    assert_equal BigDecimal.new(10.99,4), item.unit_price
  end

  def test_it_has_created_at
    parent = mock("parent")
    item = Item.new({
            :id          => 1,
            :name        => "Pencil",
            :description => "You can use it to write things",
            :merchant_id => 01234567,
            :unit_price  => BigDecimal.new(1099,4),
            :created_at  => "2016-01-11 11:30:35 UTC",
            :updated_at  => "1994-05-07 23:38:43 UTC"
            }, parent)

    assert_equal Time.parse("2016-01-11 11:30:35 UTC"), item.created_at
  end

  def test_it_has_updated_at
    parent = mock("parent")
    item = Item.new({
            :id          => 1,
            :name        => "Pencil",
            :description => "You can use it to write things",
            :merchant_id => 01234567,
            :unit_price  => BigDecimal.new(1099,4),
            :created_at  => "2016-01-11 11:30:35 UTC",
            :updated_at  => "1994-05-07 23:38:43 UTC"
            }, parent)

    assert_equal Time.parse("1994-05-07 23:38:43 UTC"), item.updated_at
  end

  def test_item_has_a_parent
    parent = mock("parent")
    item = Item.new({
            :id          => 1,
            :name        => "Pencil",
            :description => "You can use it to write things",
            :merchant_id => 01234567,
            :unit_price  => BigDecimal.new(1099,4),
            :created_at  => "11:30:34",
            :updated_at  => "18:17:19"
            }, parent)

    assert_equal parent, item.parent
  end

  def test_unit_price_to_dollars_returns_price_as_float
    parent = mock("parent")
    item = Item.new({
            :id          => 1,
            :name        => "Pencil",
            :description => "You can use it to write things",
            :merchant_id => 01234567,
            :unit_price  => BigDecimal.new(1099,4),
            :created_at  => "11:30:34",
            :updated_at  => "18:17:19"
            }, parent)

   assert_instance_of Float, item.unit_price_to_dollars
   assert_equal 10.99, item.unit_price_to_dollars
  end

end
