require './test/test_helper'

require './lib/item'

class ItemTest < Minitest::Test
  def setup
    @current_time = Time.now

    @item = Item.new({
      :id          => 1,
      :name        => "Pencil",
      :description => "You can use it to write things",
      :unit_price  => BigDecimal.new(10.99,4),
      :created_at  => @current_time,
      :updated_at  => @current_time,
      :merchant_id => 2})
  end
  
  def test_it_exists
    assert_instance_of Item, @item
  end
  
  def test_it_has_an_id
    assert_equal 1, @item.id
  end
  
  def test_it_has_a_name
    assert_equal "Pencil", @item.name
  end
  
  def test_it_has_a_description
    assert_equal "You can use it to write things", @item.description
  end
  
  def test_it_has_a_unit_price
    assert_equal BigDecimal.new(10.99,4), @item.unit_price
  end
  
  def test_it_has_a_created_at_time
    assert_equal @current_time, @item.created_at
  end
  
  def test_it_has_a_updated_at_time
    assert_equal @current_time, @item.updated_at
  end
  
  def test_it_has_a_merchant_id
    assert_equal 2, @item.merchant_id
  end
  
  def test_item_can_convert_units_to_dollars
    assert_equal "$3.00", Item.unit_price_to_dollars(3)
  end
end
