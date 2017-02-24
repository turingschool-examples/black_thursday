require './test/test_helper'
require './lib/item'

class ItemTest < Minitest::Test
  def setup
    @i = Item.new({
      :id          => 1111,
      :merchant_id => 222222,
      :name        => "Pencil",
      :description => "You can use it to write things",
      :unit_price  => BigDecimal.new(10.99,4),
      :created_at  => Time.now,
      :updated_at  => Time.now,
      })
  end
  def test_item_exists
      assert_equal "Pencil", @i.name
      assert_equal "You can use it to write things", @i.description
      assert @i.created_at
      assert @i.updated_at
      assert_equal 0.1099e2, @i.unit_price
  end

  def test_item_id
      assert_equal 1111, @i.id
  end

  def test_item_name
      assert_equal "Pencil", @i.name
  end

  def test_item_description
      assert_equal "You can use it to write things", @i.description
  end

  def test_item_unit_price
    assert_equal 0.1099e2, @i.unit_price
  end

  def test_time_stamps
    assert_instance_of Time, @i.created_at
    assert_instance_of Time, @i.updated_at
  end

  def test_unit_price_to_dollars
    float = 10.99
    assert_equal float, @i.unit_price_to_dollars
  end

  def test_merchant_id
    assert_equal 222222, @i.merchant_id
  end

end
