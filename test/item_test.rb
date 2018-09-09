require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/item'
require 'bigdecimal'
require 'time'

class ItemTest < Minitest::Test

  def test_it_exists
    i = Item.new({
      :id          => 1,
      :name        => "Pencil",
      :description => "You can use it to write things",
      :unit_price  => BigDecimal.new(10.99,4),
      :created_at  => Time.now,
      :updated_at  => Time.now,
      :merchant_id => 2
                  })

    assert_instance_of Item, i
  end

  def test_it_has_attributes
    i = Item.new({
      :id          => 1,
      :name        => "Pencil",
      :description => "You can use it to write things",
      :unit_price  => BigDecimal.new(10.99,4),
      :created_at  => Time.now,
      :updated_at  => Time.now,
      :merchant_id => 2
                  })

      assert_equal 1, i.id
      assert_equal "Pencil", i.name
      assert_equal "You can use it to write things", i.description
      assert_equal BigDecimal.new(10.99,4), i.unit_price
      assert_equal Time.now.to_s, i.created_at.to_s
      assert_equal Time.now.to_s, i.updated_at.to_s
      assert_equal 2, i.merchant_id
  end

end
