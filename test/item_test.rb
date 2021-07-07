require './test/test_helper'
require './lib/item'

class ItemTest < Minitest::Test

  def test_it_exists
    item = Item.new(
      id: 1,
      name: "Pencil",
      description: "You can use it to write things",
      unit_price: BigDecimal.new(10.99,4),
      created_at: '2016-01-11 11:51:36 UTC',
      updated_at: '2001-09-17 15:28:43 UTC',
      merchant_id: 2
    )

    assert_instance_of Item, item
  end

  def test_it_has_attributes
    item = Item.new(
      id: 1,
      name: "Pencil",
      description: "You can use it to write things",
      unit_price: BigDecimal.new(10.99,4),
      created_at: '2016-01-11 11:51:36 UTC',
      updated_at: '2001-09-17 15:28:43 UTC',
      merchant_id: 2
    )

    assert_equal 1, item.id
    assert_equal "Pencil", item.name
    assert_equal "You can use it to write things", item.description
    assert_equal 0.1099, item.unit_price
    assert_equal Time.parse('2016-01-11 11:51:36 UTC'), item.created_at
    assert_equal Time.parse('2001-09-17 15:28:43 UTC'), item.updated_at
    assert_equal 2, item.merchant_id
  end



end
