require './test/test_helper'

class ItemTest < Minitest::Test

def setup
  @i = Item.new({
  :id          => 1,
  :name        => "Pencil",
  :description => "You can use it to write things",
  :unit_price  => BigDecimal.new(10.99, 4),
  :created_at  => Time.now,
  :updated_at  => Time.now,
  :merchant_id => 2
  })
end

  def test_it_exists
    assert_instance_of Item, @i
  end

  def test_it_has_attributes
    assert_equal  1, @i.id
    assert_equal "Pencil", @i.name
    assert_equal "You can use it to write things", @i.description
    assert_equal 2, @i.merchant_id.to_i
    assert 10.99, @i.unit_price
    assert_equal Time, @i.created_at.class
    assert_equal 10.99, @i.unit_price_to_dollars
  end

  def test_it_can_update
    skip
    updated_item = {
     :name        => "Pen",
     :description => "You can use it to write things like a boss",
     :unit_price  => BigDecimal.new(14.50, 4),
     :updated_at  => Time.now,
     }

    @i.update(updated_item)
    assert_equal  1, @i.id
    assert_equal "Pen", @i.name
    assert_equal "You can use it to write things like a boss", @i.description
    assert_equal 2, @i.merchant_id.to_i
    assert 14.50, @i.unit_price
    assert_equal Time, @i.created_at.class
    # assert_equal 14.50, @i.unit_price_to_dollars
  end
end
