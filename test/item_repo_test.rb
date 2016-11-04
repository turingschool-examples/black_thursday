require 'minitest/autorun'
require 'minitest/pride'
require './lib/item_repo'
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
    name = "Collection Jade, Composition : 2 lanières cuir veau 5 mm"
    assert_equal 263402963,i.find_by_name(name)
  end

  def test_it_can_find_item_price_by_id
    i = ItemRepo.new(file, sales_engine)
    assert_equal 25000, i.find_item_price_by_id(263402963)
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
    assert_equal item, i.find_all_by_price(3800)
  end

  def test_it_can_find_by_price_in_range
    i = ItemRepo.new(file, sales_engine)
    item = "Peinture sur bois - carré, couleurs - 50 x 50 cm"
    assert_equal item, i.find_all_by_price_in_range(3790, 3810)
  end

  def test_it_can_find_by_merchant_id
    i = ItemRepo.new(file, sales_engine)
    item = "Peinture sur bois - carré, couleurs - 50 x 50 cm"
    assert_equal item, i.find_all_by_merchant_id("12334871")
  end

end