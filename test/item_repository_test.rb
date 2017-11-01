require_relative 'test_helper'
require './lib/item_repository'
require 'pry'
require 'csv'
require 'date'
require 'bigdecimal'
class ItemRepositoryTest < Minitest:: Test

  def test_it_creates_item
    ir = ItemRepository.new("")
    ir.create_item({
      :items   => "./test/fixtures/items_fixture_5lines.csv",
    })

    assert_instance_of ItemRepository, ir
  end

  def test_it_can_return_all_items
    ir  = ItemRepository.new("")
    ir.create_item({
      :items   => "./test/fixtures/items_fixture_5lines.csv",
    })
    result1 = ir.all.first.name
    result2 = ir.all.last.name
    name1 = "510+ RealPush Icon Set"
    name2 = "Kindersocken (Söckchen), hangestrickt, Länge ca.15 cm, beige (eierschalenfarben)"

    assert_equal name1, result1
    assert_equal name2, result2
  end

  def test_it_can_find_items_by_the_id
    ir  = ItemRepository.new("")
    ir.create_item({
      :items   => "./test/fixtures/items_fixture_5lines.csv",
    })
    row1 = ir.items[1]
    row2 = ir.items[2]

    assert_equal row1 , ir.find_by_id("263395617")
    assert_equal row2 , ir.find_by_id("263395721")
  end

  def test_it_can_find_all_items_by_name
    ir  = ItemRepository.new("")
    ir.create_item({
      :items   => "./test/fixtures/items_fixture_5lines.csv",
    })
    row1 = ir.items[5]
    row2 = ir.items[0]

    assert_equal row1,  ir.find_by_name("Cache cache à la plage")
    assert_equal row2,  ir.find_by_name("510+ RealPush Icon Set")

  end

  def test_it_can_find_all_items_by_description
    ir  = ItemRepository.new("")
    ir.create_item({
      :items   => "./test/fixtures/items_fixture_5lines.csv",
    })
    row = ir.items[1]
    description = "Glitter scrabble frames\n\nAny colour glitter\nAny wording\n\nAvailable colour scrabble tiles\nPink\nBlue\nBlack\nWooden"

    assert_equal [row],  ir.find_all_by_description(description)
  end

  def test_it_can_find_all_items_by_price
    ir  = ItemRepository.new("")
    ir.create_item({
      :items   => "./test/fixtures/items_fixture_5lines.csv",
    })
    row = ir.items[5]

    assert_equal [row],  ir.find_all_by_price("14900")
  end

  def test_it_can_find_all_items_within_range
    ir  = ItemRepository.new("")
    ir.create_item({
      :items   => "./test/fixtures/items_fixture_5lines.csv",
    })

    assert_equal ["Vogue Paris Original Givenchy 2307",
       "Cache cache à la plage"],  ir.find_all_by_price_in_range("2000","15000")
  end

  def test_it_can_find_all_items_by_the_merchant_id

    ir  = ItemRepository.new("")
    ir.create_item({
      :items   => "./test/fixtures/items_fixture_5lines.csv",
    })
    row = ir.items.first

    assert_equal [row] , ir.find_all_by_merchant_id("12334115")
  end


# all - returns an array of all known Item instances
# find_by_id - returns eier nil or an instance of Item with a matching ID
# find_by_name - returns either nil or an instance of Item having done a case insensitive search
# find_all_with_description - returns either [] or instances of Item where the supplied string appears in the item description (case insensitive)
# find_all_by_price - returns either [] or instances of Item where the supplied price exactly matches
# find_all_by_price_in_range - returns either [] or instances of Item where the supplied price is in the supplied range (a single Ruby range instance is passed in)
# find_all_by_merchant_id - returns either [] or instances of Item where the supplied merchant ID matches that supplied

end
