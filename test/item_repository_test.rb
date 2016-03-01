gem 'minitest', '~> 5.2'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/item'

class ItemRepositoryClassTest < Minitest::Test

  def setup
    item1 = Item.new({:id => 2342,
                     :name => "MY Item",
                     :description => "Best item ever",
                     :unit_price => 1500,
                     :merchant_id => 23,
                     :created_at => Time.now,
                     :updated_at => Time.now})
    item2 = Item.new({:id => 2341,
                     :name => "Another item",
                     :description => "Mediocre item",
                     :unit_price => 1200,
                     :merchant_id => 22,
                     :created_at => Time.now,
                     :updated_at => Time.now})
   item3 = Item.new({:id => 2438,
                    :name => "Tertiary item",
                    :description => "This is an item",
                    :unit_price => 1100,
                    :merchant_id => 22,
                    :created_at => Time.now,
                    :updated_at => Time.now})
    @items = [item1, item2, item3]
    item_repository = ItemRepository.new
    item_repository.repository << items

  end

  def test_can_get_an_array_of_all_items_in_the_item_repository
    expected = []
  end


end
