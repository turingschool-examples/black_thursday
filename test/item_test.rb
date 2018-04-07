require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/item'

class ItemTest  < Minitest::Test

  def test_it_exists
    item = Item.new({
        :name => 'Pencil',
        :description => 'Can be used to write things',
        :unit_price => BigDecimal.new(10.99, 4),
        :created_at => Time.now,
        :updated_at => Time.now
      })

      assert_instance_of Item, item
  end

  def test_it_has_attributes
    item = Item.new({
        :name => 'Pencil',
        :description => 'Can be used to write things',
        :unit_price => BigDecimal.new(10.99, 4),
        :created_at => Time.now,
        :updated_at => Time.now
      })

      assert_equal "Pencil", item.name
      assert_equal "You can use it to write things", item.description
      assert_equal 10.99, item.unit_price
      assert_equal Time.now, item.created_at
      assert_equal Time.now, item.updated_at
  end
end
