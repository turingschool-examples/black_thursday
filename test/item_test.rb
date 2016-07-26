require './test/test_helper'
require './lib/item'

class ItemTest < Minitest::Test
  def test_initializing_with_a_hash
    item = Item.new({:name => "Jean"})

    assert_equal "Jean", item.name
  end

  def test_it_has_all_the_things
    item = Item.new({:id => 2663713, :name => "Jean", :description => "Whatever", :unit_price => 10.997,
      :merchant_id => 5, :created_at => Time.now, :updated_at => Time.now})

      assert_equal 2663713, item.id
      assert_equal "Jean", item.name
      assert_equal "Whatever", item.description
      assert_equal 10.997, item.unit_price
      assert_equal 5, item.merchant_id
      assert_respond_to item, :created_at
      assert_respond_to item, :updated_at
  end

  def test_it_accepts_partial_data
    item = Item.new({:id => 1, :name => "Tiny store"})
    assert_equal 1, item.id
    assert_equal nil, item.description
  end

  

end
