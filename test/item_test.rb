require_relative 'test_helper'
require_relative '../lib/item'

class ItemTest < MiniTest::Test
  def setup
    @item = Item.new({
                      :id          => 1,
                      :name        => "Pencil",
                      :description => "You can use it to write things"
                      :unit_price  => BigDecimal.new(10.99,4),
                      :created_at  => Time.now,
                      :updated_at  => Time.now,
                      :merchant_id => 2
                    })
  end

  def test_it_exists
    assert_instance_of Item, @item
  end

  def test_it_has_a_name
    assert_equal "Pencil", @item.name
  end

  def test_it_has_a_description
    assert_equal "You can use it to write things", @item.description
  end

end
