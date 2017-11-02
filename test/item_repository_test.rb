require_relative 'test_helper'
require './lib/item_repository'
require 'pry'
require 'csv'
require 'date'
require 'bigdecimal'
class ItemRepositoryTest < Minitest:: Test

  def test_it_creates_item
    ir = ItemRepository.new("")
    ir.create_item(
     "./test/fixtures/items_fixture_5lines.csv",
    )
    assert_instance_of ItemRepository, ir
  end

  def test_it_can_return_all_items
    ir  = ItemRepository.new("")
    ir.create_item(
       "./test/fixtures/items_fixture_5lines.csv",
    )
    # binding.pry
    result_class = ir.all.map{|item|item.class}.uniq.pop
    result_count = ir.all.count
        # binding.pry
    assert Item, result_class
    assert_equal 1088, result_count
  end

  def test_it_can_find_items_by_the_id
    ir  = ItemRepository.new("")
    ir.create_item(
    "./test/fixtures/items_fixture_5lines.csv",
    )
    row1 = ir.items[1]
    row2 = ir.items[2]

    assert_equal row1 , ir.find_by_id("263395617")
    assert_equal row2 , ir.find_by_id("263395721")
  end

  def test_it_can_find_all_items_by_name
    ir  = ItemRepository.new("")
    ir.create_item(
       "./test/fixtures/items_fixture_5lines.csv",
    )
    row1 = ir.items[5]
    row2 = ir.items[0]

    assert_equal row1,  ir.find_by_name("Cache cache à la plage")
    assert_equal row2,  ir.find_by_name("510+ RealPush Icon Set")
  end

  def test_it_can_find_all_items_by_description
    ir  = ItemRepository.new("")
    ir.create_item(
      "./test/fixtures/items_fixture_5lines.csv",
    )
    row = ir.items[1]
    description = "Glitter scrabble frames\n\nAny colour glitter\nAny wording\n\nAvailable colour scrabble tiles\nPink\nBlue\nBlack\nWooden"

    assert_equal [row],  ir.find_all_by_description(description)
  end

  def test_it_can_find_all_items_by_price
    ir  = ItemRepository.new("")
    ir.create_item(
    "./test/fixtures/items_fixture_5lines.csv",
    )

    number_of_items_with_price = ir.find_all_by_price(16300)
    assert_equal 1,  number_of_items_with_price.count
  end

  def test_it_can_find_all_items_within_range
    ir  = ItemRepository.new("")
    ir.create_item(
       "./test/fixtures/items_fixture_5lines.csv",
    )
        row =["Free standing Woden letters", "Vintage Lego Duplo Windows 6 Red Yellow Green Windows/Doors", "Paper bag", "CAMPING REFLECTIONS", "scarf", "Gray Mudd Cardigan Medium", "Magick Golden Salve 1 oz", "Vanilla Scented Candles", "Personalized Valentines", "Vintage Album Blue Oyster Cult, Agents of Fortune, vintage, 1976, fair condition, Don&#39;t Fear the Reaper, art, music, rock and roll, classic", "Upside Down Wineglass Candle Holder", "Earflap hat for infant", "New California Republic Patch w/ hook velcro backing"]

    assert_equal row,  ir.find_all_by_price_in_range(690,701)
  end

  def test_it_can_find_all_items_by_the_merchant_id
    ir  = ItemRepository.new("")
    # binding.pry
    ir.create_item(
    "./test/fixtures/items_fixture_5lines.csv"
    )

    assert_equal 2 , ir.find_all_by_merchant_id(12334115).count
    assert Item, ir.find_all_by_merchant_id(12334115).class
  end


# all - returns an array of all known Item instances
# find_by_id - returns eier nil or an instance of Item with a matching ID
# find_by_name - returns either nil or an instance of Item having done a case insensitive search
# find_all_with_description - returns either [] or instances of Item where the supplied string appears in the item description (case insensitive)
# find_all_by_price - returns either [] or instances of Item where the supplied price exactly matches
# find_all_by_price_in_range - returns either [] or instances of Item where the supplied price is in the supplied range (a single Ruby range instance is passed in)
# find_all_by_merchant_id - returns either [] or instances of Item where the supplied merchant ID matches that supplied

end
