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

    result = {:name=>"Glitter scrabble frames", :description=>"Glitter scrabble frames \nAny colour glitter \nAny wording\nAvailable colour scrabble tiles\nPink\nBlue\nBlack\nWooden", :unit_price=>"1300", :created_at=>"2016-01-11 11:51:37 UTC", :updated_at=>"1993-09-29 11:56:40 UTC"}
    assert_equal result, ir.format_item_info(item[1])
  end


  # def test_it_populates_repository_with_items
  #   ir = ItemRepository.new
  #   items = CSV.read("./data/items_sample.csv", headers: true, header_converters: :symbol)
  #   ir.populate(items)
  #
  #   assert_equal 10, ir.items.count
  # end
  #
  # def test_it_returns_an_item_from_repository
  #   ir = ItemRepository.new
  #   items = CSV.read("./data/items_sample.csv", headers: true, header_converters: :symbol)
  #   ir.populate(items)
  #   assert_instance_of Item, ir.items[items[0][:id]]
  # end
  #
  # def test_it_returns_a_list_of_items
  #   ir = ItemRepository.new
  #   items = CSV.read("./data/items_sample.csv", headers: true, header_converters: :symbol)
  #   ir.populate(items)
  #
  #   assert_equal Array, ir.all.class
  #   assert_equal 10, ir.all.count
  #   assert_instance_of Item, ir.all.sample
  # end
  #
  # def test_it_finds_the_item_by_id
  #   ir = ItemRepository.new
  #   items = CSV.read("./data/items_sample.csv", headers: true, header_converters: :symbol)
  #   ir.populate(items)
  #
  #   assert_instance_of Item, ir.find_by_id("12334105")
  #   assert_instance_of Item, ir.find_by_id("12334135")
  #   assert_equal nil, ir.find_by_id("1234567")
  # end
  #
  # def test_it_finds_the_item_by_name
  #   ir = ItemRepository.new
  #   items = CSV.read("./data/items_sample.csv", headers: true, header_converters: :symbol)
  #   ir.populate(items)
  #
  #   assert_instance_of Item, ir.find_by_name("Shopin1901")
  #   assert_instance_of Item, ir.find_by_name("ShOPiN1901")
  #   assert_instance_of Item, ir.find_by_name("Keckenbauer")
  #   assert_instance_of Item, ir.find_by_name("KECKENBAUER")
  #   assert_equal nil, ir.find_by_name("onlineshop")
  # end
  #
  # def test_it_finds_all_items_by_supplied_name_fragment
  #   ir = ItemRepository.new
  #   items = CSV.read("./data/items_sample.csv", headers: true, header_converters: :symbol)
  #   ir.populate(items)
  #
  #   assert_equal [], ir.find_all_by_name("piney")
  #
  #   found_names = ir.find_all_by_name("pin").map { |item| item.name }
  #   assert_equal ["Shopin1901"], found_names
  #
  #   found_names = ir.find_all_by_name("pIN").map { |item| item.name }
  #   assert_equal ["Shopin1901"], found_names
  #
  #   found_names = ir.find_all_by_name("en").map { |item| item.name }
  #   assert_equal ["Keckenbauer", "GoldenRayPress"], found_names
  #
  #   found_names = ir.find_all_by_name("EN").map { |item| item.name }
  #   assert_equal ["Keckenbauer", "GoldenRayPress"], found_names
  # end
end
