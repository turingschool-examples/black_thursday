require_relative 'test_helper'
require_relative '../lib/item'

class ItemTest < Minitest::Test
  def test_it_starts_an_item_instance
    item = Item.new({
                      :name        => "Pencil",
                      :description => "You can use it to write things",
                      :unit_price  => BigDecimal.new(10.99,4),
                      :created_at  => Time.now,
                      :updated_at  => Time.now,
                    })

    assert_instance_of Item, item
  end

  def test_attr_reader_works
    item = Item.new({
                      :name        => "Pencil"
                    })

    assert_equal "Pencil", item.name
  end

  def test_attr_reader_works_for_other_attributes
    item = Item.new({
                      :unit_price  => BigDecimal.new(10.99,4)
                    })
    expected = "0.1099E2"

    assert_equal expected, item.unit_price.to_s
  end

  def test_instance_created_at_works
    item = Item.new({
                      :created_at  => Time.now
                    })
    actual = item.created_at.class
    expected = Time

    assert_equal expected, actual
  end

  def test_it_returns_the_unit_price_to_dollars
    item = Item.new({
                      :unit_price  => BigDecimal.new(10.99,4),
                    })
    expected = "10.99"

    assert_equal expected, item.unit_price_to_dollars
  end

end
