require "minitest/pride"
require "minitest/autorun"
require "bigdecimal"
require "./lib/item"


class ItemTest < Minitest::Test
  def test_it_exists
    item = Item.new({
      :name        => "Pencil",
      :description => "You can use it to write things",
      :unit_price  => BigDecimal.new(10.99,4),
      :created_at  => Time.now,
      :updated_at  => Time.now,
      })

    assert_instance_of Item, item
  end

  def test_it_has_attributes
    item = Item.new({
      :name        => "Pencil",
      :description => "You can use it to write things",
      :unit_price  => BigDecimal.new(10.99,4),
      :created_at  => Time.now,
      :updated_at  => Time.now,
      })

    assert_equal "Pencil", item.name
    assert_equal "You can use it to write things", item.description
    assert_equal 0.1099e2, item.unit_price
    assert_instance_of Time, item.created_at
    assert_instance_of Time, item.updated_at
  end

  def test_it_can_have_different_attributes
    item = Item.new({
      :name        => "Apple",
      :description => "A fruit that grows on trees",
      :unit_price  => BigDecimal.new(3.99,4),
      :created_at  => Time.at(1498232400),
      :updated_at  => Time.at(1498280000),
      })
    created_time = Time.at(1498232400)
    updated_time = Time.at(1498280000)

    assert_equal "Apple", item.name
    assert_equal "A fruit that grows on trees", item.description
    assert_equal 0.0399e2, item.unit_price
    assert_equal created_time, item.created_at
    assert_equal updated_time, item.updated_at
  end

  def test_unit_price_converts_to_dollar
    item = Item.new({
      :name        => "Pencil",
      :description => "You can use it to write things",
      :unit_price  => BigDecimal.new(10.99,4),
      :created_at  => Time.now,
      :updated_at  => Time.now,
      })

    assert_equal 10.99, item.unit_price_to_dollars
  end

end
