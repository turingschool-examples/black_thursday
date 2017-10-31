require_relative 'test_helper'
require './lib/item_repository'
require 'pry'
require 'csv'
require 'date'
class ItemRepositoryTest < Minitest:: Test

  def test_it_creates_item

    ir = ItemRepository.new("")
    # assert_equal 0, ir.count
    ir.create_item({
      :items   => "./data/items_fixture_5lines.csv",
    })

    assert_equal "Glitter scrabble frames", ir.items_store.first.name
  end
  def test_it_can_return_all_items

    ir  = ItemRepository.new("")
    ir.create_item({
      :items   => "./data/items_fixture_5lines.csv",
    })
    assert_equal "Cache cache à la plage", ir.items_store.last.name

  end
  def test_it_can_find_all_items_by_id
  end
  def test_it_can_find_all_items_by_name
  end
  def test_it_can_find_all_items_by_description
  end
  def test_it_can_find_all_items_by_price
  end
  def test_it_can_find_all_items_within_range
  end
  def test_it_can_find_all_items_by_id
  end


# all - returns an array of all known Item instances
# find_by_id - returns eier nil or an instance of Item with a matching ID
# find_by_name - returns either nil or an instance of Item having done a case insensitive search
# find_all_with_description - returns either [] or instances of Item where the supplied string appears in the item description (case insensitive)
# find_all_by_price - returns either [] or instances of Item where the supplied price exactly matches
# find_all_by_price_in_range - returns either [] or instances of Item where the supplied price is in the supplied range (a single Ruby range instance is passed in)
# find_all_by_merchant_id - returns either [] or instances of Item where the supplied merchant ID matches that supplied

end
