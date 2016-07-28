require './test/test_helper'
require './lib/item_repository'
require 'csv'

class ItemRepositoryTest < Minitest::Test
  attr_reader :items,
              :ir

  def setup
    @items = CSV.read("./data/items_sample.csv", headers: true, header_converters: :symbol)
    @ir = ItemRepository.new(items)
  end

  def test_it_exists
    assert_instance_of ItemRepository, ir
  end

  def test_it_formats_item_info
    result = { :id          => "263395617",
               :name        => "Glitter scrabble frames",
               :description => "Glitter scrabble frames \n\nAny colour glitter \nAny wording\n\nAvailable colour scrabble tiles\nPink\nBlue\nBlack\nWooden",
               :unit_price  => "1300",
               :created_at  => "2016-01-11 11:51:37 UTC",
               :updated_at  => "1993-09-29 11:56:40 UTC",
               :merchant_id => "12334185" }
    assert_equal result, ir.format_item_info(items[1])
  end

  def test_it_populates_repository_with_items
    assert_equal 10, ir.items.count
  end

  def test_it_returns_an_item_from_repository
    assert_instance_of Item, ir.items[items[0][:id]]
  end

  def test_it_returns_a_list_of_items
    assert_equal Array,      ir.all.class
    assert_equal 10,         ir.all.count
    assert_instance_of Item, ir.all.sample
  end

  def test_it_finds_an_item_by_id
    assert_instance_of Item, ir.find_by_id("263395237")
    assert_instance_of Item, ir.find_by_id("263395237")
    assert_equal nil,        ir.find_by_id("1234567")
  end

  def test_it_finds_an_item_by_name
    assert_instance_of Item, ir.find_by_name("GLITter scrabble frames")
    assert_instance_of Item, ir.find_by_name("Disney scrabble frames")
    assert_instance_of Item, ir.find_by_name("Cache cache à la plage")
    assert_instance_of Item, ir.find_by_name("Cache cache à la PLAGE")
    assert_equal nil,        ir.find_by_name("onlineshop")
  end

  def test_it_finds_all_items_that_match_a_description_fragment
    assert_equal [], ir.find_all_with_description("Setting")

    matching_items = ir.find_all_with_description("glitter").map do |item|
      item.name
    end
    assert_equal ["Glitter scrabble frames", "Disney scrabble frames"], matching_items

    matching_items = ir.find_all_with_description("HEROku").map do |item|
      item.name
    end
    assert_equal ["510+ RealPush Icon Set"], matching_items

    matching_items = ir.find_all_with_description("scrabble").map do |item|
      item.name
    end
    assert_equal ["Glitter scrabble frames", "Disney scrabble frames"], matching_items

    matching_items = ir.find_all_with_description("1980").map do |item|
      item.name
    end
    assert_equal ["Vogue Paris Original Givenchy 2307"], matching_items
  end

  def test_it_finds_all_items_that_match_a_price
    matching_items = ir.find_all_by_price("2999").map do |item|
      item.name
    end
    assert_equal ["Vogue Paris Original Givenchy 2307"], matching_items

    matching_items = ir.find_all_by_price("99").map do |item|
      item.name
    end
    assert_equal [], matching_items

    matching_items = ir.find_all_by_price("1490").map do |item|
      item.name
    end
    assert_equal ["Eule - Topflappen, handgehäkelt, Paar"], matching_items

    matching_items = ir.find_all_by_price("14900").map do |item|
      item.name
    end
    assert_equal ["Cache cache à la plage"], matching_items
  end

  def test_it_finds_all_items_that_match_a_price_range
    matching_items = ir.find_all_by_price_in_range(0..1000).map do |item|
      item.name
    end
    result = ["Free standing Woden letters", "Kindersocken (Söckchen), hangestrickt, Länge ca.15 cm, beige (eierschalenfarben)"]
    assert_equal result, matching_items

    matching_items = ir.find_all_by_price_in_range(1150..1200).map do |item|
      item.name
    end
    result = ["510+ RealPush Icon Set"]
    assert_equal result, matching_items

    matching_items = ir.find_all_by_price_in_range(20000..40000).map do |item|
      item.name
    end
    result = ["Course contre la montre"]
    assert_equal result, matching_items

    matching_items = ir.find_all_by_price_in_range(0..600).map do |item|
      item.name
    end
    result = []
    assert_equal result, matching_items
  end

  def test_it_finds_all_items_that_match_a_merchant_id
    matching_items = ir.find_all_by_merchant_id("12334185").map do |item|
      item.name
    end
    result = ["Glitter scrabble frames", "Disney scrabble frames", "Free standing Woden letters"]
    assert_equal result, matching_items

    matching_items = ir.find_all_by_merchant_id("12334141").map do |item|
      item.name
    end
    result = ["510+ RealPush Icon Set"]
    assert_equal result, matching_items

    matching_items = ir.find_all_by_merchant_id("00000000").map do |item|
      item.name
    end
    result = []
    assert_equal result, matching_items
  end
end
