require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/item_repo'
require_relative "../test/test_helper"
require 'csv'
require 'pry'

class ItemRepoTest < Minitest::Test
  attr_reader :file, 
              :sales_engine

  def setup
    @file = "./data/small_item_file.csv"
    @sales_engine = Minitest::Mock.new
  end

  def test_it_has_a_class
    i = ItemRepo.new(file, sales_engine)
    assert_equal ItemRepo, i.class
  end

  def test_it_can_display_all_items
    i = ItemRepo.new(file, sales_engine)
    assert i.all
  end

  def test_it_can_search_by_id
    i = ItemRepo.new(file, sales_engine)
    assert_equal "Collection Jade", i.find_by_id(263403571).name
  end

  def test_it_can_find_by_name
    i = ItemRepo.new(file, sales_engine)
    name = "Coloris disponibles pour personnalisation"
    assert_equal 263405621, i.find_by_name(name).id
  end

  def test_it_can_can_find_by_description
    i = ItemRepo.new(file, sales_engine)
    description = "- Super Chunky knit infinity scarf
- Soft mixture of 97% Acrylic and 3% Viscose
- Beautiful, Warm, and Stylish
- Very easy to care for
Hand wash with cold water and lay flat to dry"
    assert_equal [], i.find_all_with_description(description)
  end

  def test_it_can_find_by_price
    i = ItemRepo.new(file, sales_engine)
    item = "Peinture sur bois - carré, couleurs - 50 x 50 cm"
    assert_equal item, i.find_all_by_price(250.00).first.name
  end

  def test_it_can_find_by_price_in_range
    i = ItemRepo.new(file, sales_engine)
    item = "Peinture sur bois - carré, couleurs - 50 x 50 cm"
    assert_equal item, i.find_all_by_price_in_range(250.0..300.0).first.name
  end

  def test_it_can_find_by_merchant_id
    i = ItemRepo.new(file, sales_engine)
    item = "Peinture sur bois - carré, couleurs - 50 x 50 cm"
    assert_equal item, i.find_all_by_merchant_id(12334411).first.name
  end

end