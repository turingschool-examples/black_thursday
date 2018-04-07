require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/item'

class TestItem < Minitest::Test


  def test_exists
    item = Item.new({
      :id => 12394049,
      :name => "Pencil",
      :description => "Writes stuff",
      :unit_price => 10.99,
      :created_at => Time.now,
      :updated_at => Time.now
      })

      assert_instance_of Item, item
  end

  def test_attributes
    item = Item.new({
      :id => 12394049,
      :name => "Pencil",
      :description => "Writes stuff",
      :unit_price => 10.99,
      :created_at => Time.now,
      :updated_at => Time.now
      })

    assert_equal 12394049, item.id
    assert_equal "Pencil", item.name
    assert_equal "Writes stuff", item.description
    assert_equal 10.99, item.unit_price
    # assert_equal time, item.created_at
    # assert_equal time, item.updated_at
  end

end
