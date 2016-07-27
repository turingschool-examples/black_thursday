require './test/test_helper'
require './lib/item_repository'
require 'CSV'

class ItemRepositoryTest < Minitest::Test

  def test_it_exists
    assert_instance_of ItemRepository, ItemRepository.new
  end

  def test_new_instance_has_zero_items
    ir = ItemRepository.new

    assert_equal 0, ir.items.count
  end

  def test_it_formats_item_info
    ir = ItemRepository.new
    item = CSV.read("./data/items_sample.csv", headers: true, header_converters: :symbol)

    result = {
      :id          => "263395617",
      :name        => "Glitter scrabble frames",
      :description => "Glitter scrabble frames \n\nAny colour glitter \nAny wording\n\nAvailable colour scrabble tiles\nPink\nBlue\nBlack\nWooden",
      :unit_price  => "1300",
      :created_at  => "2016-01-11 11:51:37 UTC",
      :updated_at  => "1993-09-29 11:56:40 UTC",
      :merchant_id => "12334185"
    }
    assert_equal result, ir.format_item_info(item[1])
  end

  def test_it_populates_repository_with_items
    ir = ItemRepository.new
    items = CSV.read("./data/items_sample.csv", headers: true, header_converters: :symbol)
    ir.populate(items)

    assert_equal 10, ir.items.count
  end

  def test_it_returns_an_item_from_repository
    ir = ItemRepository.new
    items = CSV.read("./data/items_sample.csv", headers: true, header_converters: :symbol)
    ir.populate(items)

    assert_instance_of Item, ir.items[items[0][:id]]
  end

  def test_it_returns_a_list_of_items
    ir = ItemRepository.new
    items = CSV.read("./data/items_sample.csv", headers: true, header_converters: :symbol)
    ir.populate(items)

    assert_equal Array, ir.all.class
    assert_equal 10, ir.all.count
    assert_instance_of Item, ir.all.sample
  end

  def test_it_finds_an_item_by_id
    ir = ItemRepository.new
    items = CSV.read("./data/items_sample.csv", headers: true, header_converters: :symbol)
    ir.populate(items)

    assert_instance_of Item, ir.find_by_id("263395237")
    assert_instance_of Item, ir.find_by_id("263395237")
    assert_equal nil, ir.find_by_id("1234567")
  end

  def test_it_finds_an_item_by_name
    ir = ItemRepository.new
    items = CSV.read("./data/items_sample.csv", headers: true, header_converters: :symbol)
    ir.populate(items)

    assert_instance_of Item, ir.find_by_name("GLITter scrabble frames")
    assert_instance_of Item, ir.find_by_name("Disney scrabble frames")
    assert_instance_of Item, ir.find_by_name("Cache cache à la plage")
    assert_instance_of Item, ir.find_by_name("Cache cache à la PLAGE")
    assert_equal nil, ir.find_by_name("onlineshop")
  end

  def test_it_finds_all_items_that_match_a_description_fragment
    ir = ItemRepository.new
    items = CSV.read("./data/items_sample.csv", headers: true, header_converters: :symbol)
    ir.populate(items)

    assert_equal [], ir.find_all_with_description("Setting")

    item_description = ir.find_all_with_description("glitter").map { |item| item.name }
    assert_equal ["Glitter scrabble frames", "Disney scrabble frames"], item_description

    item_description = ir.find_all_with_description("HEROku").map { |item| item.name }
    assert_equal ["510+ RealPush Icon Set"], item_description

    item_description = ir.find_all_with_description("scrabble").map { |item| item.name }
    assert_equal ["Glitter scrabble frames", "Disney scrabble frames"], item_description

    item_description = ir.find_all_with_description("1980").map { |item| item.name }
    assert_equal ["Vogue Paris Original Givenchy 2307"], item_description
  end

  def test_it_finds_all_items_that_match_a_price
    
  end

  # def test_it_finds_all_items_that_match_a_price_range
  # end
  #
  # def test_it_finds_all_items_that_match_a_merchant_id
  #
  # end
end
