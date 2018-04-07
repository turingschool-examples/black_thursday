require_relative 'test_helper'
require_relative '../lib/item'

class ItemTest < Minitest::Test

  def test_it_exists
    item = Item.new({:id => 2})
    assert_instance_of Item, item
  end

  def test_it_has_attributes
    time = Time.now
    i = Item.new({
      :id          => 3,
      :name        => "Pencil",
      :description => "You can use it to write things",
      :unit_price  => 10.99, # BigDecimal.new(10.99,4),
      :created_at  => time,
      :updated_at  => time,
      })
      assert_equal 3, i.id
      assert_equal "Pencil", i.name
      assert_equal "You can use it to write things", i.description
      assert_equal 10.99, i.unit_price # BigDecimal.new(10.99,4)
      assert_equal time, i.created_at
      assert_equal time, i.updated_at
  end

end
