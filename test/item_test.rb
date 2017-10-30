require './test/test_helper'

class TestItem < Minitest::Test
  def test_it_initializes_with_attributes
    item = Item.new({id: 12345,
                    name: "Key Pad",
                    description: "Numberpad used for a lock",
                    unit_price: BigDecimal.new(5),
                    merchant_id: 54321,
                    created_at: Time.now,
                    updated_at: Time.now})

    assert_instance_of Item, item
    assert_equal 12345, Item.id
    assert_equal "Key Pad", Item.name
    assert_equal "Numberpad used for a lock", Item.description
    assert_equal 0.5e1, Item.unit_price
    assert_equal 54321, Item.merchant_id
    assert_equal Time.now, Item.created_at
    assert_equal Time.now, Item.updated_at
  end
end
