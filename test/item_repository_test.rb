require './test/test_helper'
require './lib/item_repository'
require './lib/item'
require 'csv'

class ItemRepositoryTest < Minitest::Test
  attr_reader :ir

  def setup
    items_file = CSV.open("./data/items.csv",
                          headers:true,
                          header_converters: :symbol)
    csv_rows = items_file.map { |row| row }
    @ir = ItemRepository.new(csv_rows)
  end

  def test_item_is_instantiated_with_correct_attributes
    items_file = CSV.open("./test/testdata/items_single.csv",
                          headers:true,
                          header_converters: :symbol)
    csv_rows = items_file.map { |row| row }
    ir = ItemRepository.new(csv_rows)
    assert_equal 263415243, ir.items[0].id
    assert_equal "Davido Gracia Genuine Python tote" , ir.items[0].name
    assert_equal "Beautiful genuine Python tote", ir.items[0].description
    assert_equal 120.99, ir.items[0].unit_price
    assert_equal 12334155, ir.items[0].merchant_id
    assert_equal Time.parse('2016-01-11 15:11:05 UTC'), ir.items[0].created_at
    assert_equal Time.parse('2003-02-19 16:49:05 UTC'), ir.items[0].updated_at
  end

  def test_items_is_an_array_of_item_instances
    assert_equal Array, ir.items.class
    assert_equal true, ir.items.all? { |thing| thing.class == Item}
  end

  def test_method_all_returns_array_known_item_instances
    assert_equal ir.items, ir.all
  end

  def test_method_find_by_id_returns_nil_or_item_instance
    find_1 = ir.find_by_id(263415243)
    find_2 = ir.find_by_id('googleypuff')
    assert_equal Item, find_1.class
    assert_equal 263415243, find_1.id
    assert_equal nil, find_2
  end

  def test_method_find_by_name_returns_nil_or_item_instance
    find_1 = ir.find_by_name("Moyenne toile")
    find_2 = ir.find_by_name("moyenne TOILE")
    find_3 = ir.find_by_name("Donkey the dinosaur part 2")
    assert_equal Item, find_1.class
    assert_equal "Moyenne toile", find_1.name
    assert_equal "Moyenne toile", find_2.name
    assert_equal nil, find_3
  end

  def test_method_find_all_with_description_returns_array_of_matches
    desc_1 = "honey is a unique condiment great on cheese plates"
    desc_2 = "this"
    desc_3 = "i do not not not believe this is something someone ever wrote"
    find_1 = ir.find_all_with_description(desc_1)
    find_2 = ir.find_all_with_description(desc_2)
    find_3 = ir.find_all_with_description(desc_3)
    assert_equal Array, find_1.class
    assert_equal 5, find_1.length
    assert_equal Array, find_2.class
    assert_equal true, find_2.length > 1
    assert_equal [], find_3
  end


end
