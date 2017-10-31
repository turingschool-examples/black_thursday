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

    assert_equal "510+ RealPush Icon Set", ir.items.first.name
  end
  def test_it_can_return_all_items
    ir  = ItemRepository.new("")
    ir.create_item({
      :items   => "./data/items_fixture_5lines.csv",
    })

    assert_equal"Kindersocken (Söckchen), hangestrickt, Länge ca.15 cm, beige (eierschalenfarben)", ir.items.last.name
  end
  def test_it_can_find_all_items_by_the_id
      ir  = ItemRepository.new("")
      ir.create_item({
        :items   => "./data/items_fixture_5lines.csv",
      })
      row = ir.items[1]

      assert_equal row.id , ir.find_by_id("263395617")
  end

  def test_it_can_find_all_items_by_name
    ir  = ItemRepository.new("")
    ir.create_item({
      :items   => "./data/items_fixture_5lines.csv",
    })
    row = ir.items[5].name

    assert_equal "Cache cache à la plage",  ir.find_by_name("Cache cache à la plage")
  end

  def test_it_can_find_all_items_by_description

    ir  = ItemRepository.new("")
    ir.create_item({
      :items   => "./data/items_fixture_5lines.csv",
    })
    row = ir.items[5]

    assert_equal "Glitter scrabble frames",  ir.find_all_by_description("Glitter scrabble frames\n\nAny colour glitter\nAny wording\n\nAvailable colour scrabble tiles\nPink\nBlue\nBlack\nWooden")
  end

  def test_it_can_find_all_items_by_price

    ir  = ItemRepository.new("")
    ir.create_item({
      :items   => "./data/items_fixture_5lines.csv",
    })
    row = ir.items[4]

    assert_equal "Cache cache à la plage",  ir.find_by_price("14900")
  end

  def test_it_can_find_all_items_within_range

    ir  = ItemRepository.new("")
    ir.create_item({
      :items   => "./data/items_fixture_5lines.csv",
    })
    row = ir.items

    assert_equal ["Vogue Paris Original Givenchy 2307",
       "Cache cache à la plage"],  ir.find_all_by_price_in_range("2000","15000")
  end

  def test_it_can_find_all_items_by_the_merchant_id
    skip
    ir  = ItemRepository.new("")
    ir.create_item({
      :items   => "./data/items_fixture_5lines.csv",
    })
    row = ir.items.first

    assert_equal [row] , ir.find_all_by_merchant_id("12334141")
  end


# all - returns an array of all known Item instances
# find_by_id - returns eier nil or an instance of Item with a matching ID
# find_by_name - returns either nil or an instance of Item having done a case insensitive search
# find_all_with_description - returns either [] or instances of Item where the supplied string appears in the item description (case insensitive)
# find_all_by_price - returns either [] or instances of Item where the supplied price exactly matches
# find_all_by_price_in_range - returns either [] or instances of Item where the supplied price is in the supplied range (a single Ruby range instance is passed in)
# find_all_by_merchant_id - returns either [] or instances of Item where the supplied merchant ID matches that supplied

end
