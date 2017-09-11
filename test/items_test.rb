require_relative 'test_helper'
require './lib/item'

class ItemsTest < Minitest::Test

  def test_it_exists
    item = {:name=>'Pencil', :description=>'You can use it to write things', :unit_price=>4.30, :created_at=>Time.now, :updated_at=>Time.now}

    assert_instance_of Item, Item.new(item)
  end

  def test_it_can_find_item_name
    item = {:name=>'Pencil', :description=>'You can use it to write things', :unit_price=>4.30, :created_at=>Time.now, :updated_at=>Time.now}


    assert_equal "Pencil", Item.new(item).name
  end

end
