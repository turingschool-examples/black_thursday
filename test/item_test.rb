require 'simplecov'
SimpleCov.start

require 'minitest/pride'
require 'minitest/autorun'
require 'bigdecimal'
require_relative '../lib/item'

class ItemTest < Minitest::Test

  def setup
    @item = Item.new({id: 1084930,
                      name: "Pencil",
                      description: "You can use it to write things",
                      unit_price: 1099,
                      created_at: "2018-04-01 00:00:00",
                      updated_at: "2018-04-01 00:00:00"
                      })
  end

  def test_it_exists
    assert_instance_of Item, @item
  end

  def test_it_has_attributes
    id = 1084930
    name = "Pencil"
    description = "You can use it to write things"
    unit_price = BigDecimal.new(10.99, 4).to_f
    created_at = Time.parse("2018-04-01 00:00:00")
    updated_at = Time.parse("2018-04-01 00:00:00")

    assert_equal id, @item.id
    assert_equal name, @item.name
    assert_equal description, @item.description
    assert_equal unit_price, @item.unit_price.to_f
    assert_equal created_at, @item.created_at
    assert_equal updated_at, @item.updated_at
  end

  def test_it_can_convert_price_to_dollars
    expected = 10.99
    result = @item.unit_price_to_dollars

    assert_equal expected, result
  end

end
