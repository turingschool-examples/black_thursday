require './test/test_helper'
require './lib/items'
require 'bigdecimal'

class ItemTest < Minitest::Test

  def setup
    @i = Items.new({
      :id          => 123456,
      :name        => "Pencil",
      :description => "You can use it to write things",
      :unit_price  => BigDecimal.new(10.99,4),
      :created_at  => Time.now,
      :updated_at  => Time.now,
    })
  end

  def test_item_initializes_with_id
    id = 123456
    assert_equal id, @i.id
  end

  def test_item_initializes_with_name
    skip
    name = "Pencil"
    assert_equal name, @i.name
  end

  def test_item_initializes_with_description
    skip
    description = "You can use it to write things"
    assert_equal description, @i.description
  end

  def test_item_initializes_with_unit_price
    skip
    unit_price  = BigDecimal.new(10.99,4)
    assert_equal unit_price, @i.unit_price
  end

  def test_item_initializes_with_created_at
    skip
    created_at  = Time.today
    assert_equal created_at, @i.created_at
  end

end
