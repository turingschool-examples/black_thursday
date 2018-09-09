require 'pry'
require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require 'minitest/pride'
require 'time'
require 'bigdecimal'
require_relative '../lib/sales_engine'
require_relative '../lib/csv_adaptor'
require_relative '../lib/merchant'
require_relative '../lib/merchant_repo'
require_relative '../lib/item'
require_relative '../lib/item_repo'

class ItemRepoTest < Minitest::Test

  def test_it_exists
    data_file = "./data/items.csv"
    ir = ItemRepo.new(data_file)

    assert_instance_of ItemRepo, ir
  end

  def test_all_item_characteristics_imports_item_objects_into_items_array
    data_file = "./data/items.csv"
    ir = ItemRepo.new(data_file)

    assert_instance_of Array, ir.all_item_characteristics(data_file)
  end

  def test_all_returns_array_of_item_objects
    data_file = "./data/items.csv"
    ir = ItemRepo.new(data_file)
    ir.all

    assert_instance_of Item, ir.items[100]
  end

  def test_find_by_id_returns_item_object_with_that_id
    data_file = "./data/items.csv"
    ir = ItemRepo.new(data_file)
    ir.all
    id = 263395721
    expected = ir.all[2]

    assert_equal expected, ir.find_by_id(id)
  end

  def test_find_by_name_returns_item_object
    data_file = "./data/items.csv"
    ir = ItemRepo.new(data_file)
    ir.all
    name = "Disney scrabble frames"
    expected = ir.all[2]

    assert_equal expected, ir.find_by_name(name)
  end

  def test_find_all_with_description_returns_items_with_description_fragment
    data_file = "./data/items.csv"
    ir = ItemRepo.new(data_file)
    ir.all
    description = "disney"

    assert_instance_of Array, ir.find_all_with_description(description)
  end

  def test_find_by_price
    r = ItemRepo.new("./data/items.csv")
    ir.all
    name = "LolaMarleys"
    expected = mr.merchants[3]

    assert_equal expected, mr.find_by_name(name)
  end

  end

end
