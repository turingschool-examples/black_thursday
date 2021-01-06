require_relative './test_helper'
require './lib/sales_engine'

class ItemRepositoryTest < Minitest::Test
  def setup
    # item_path = "./data/items.csv"
    # arguments = {:items => item_path}
    @ir = ItemRepository.new("./data/items.csv")
  end

  def test_it_exists
    assert_instance_of ItemRepository, @ir
  end

  def test_all_displays_all_items
    assert_equal 1367, @ir.all
  end

  def test_find_by_id_finds_an_item_by_id
    result_1 = @ir.find_by_id(263538760)

    assert_equal 263538760, result_1.id.to_i
    assert_equal "Puppy blankie", result_1.name

    result_2 = @ir.find_by_id(1)

    assert_nil nil, result_2
  end

  def test_find_by_name_finds_an_item_by_name
    result_1 = @ir.find_by_name("Puppy blankie")
    assert_equal "Puppy blankie", result_1.name
    assert_equal 263538760, result_1.id.to_i

    result_2 = @ir.find_by_name("Sales Engine")

    assert_nil nil, result_2
  end

  def test_find_all_with_description_finds_all_items_matching_given_description
    expected_1 = "A large Yeti of sorts, casually devours a cow as the others watch numbly."

    result_1 = @ir.find_all_with_description(expected_1)

    assert_equal expected_1, result_1[0].description
    assert_equal 263550472, result_1[0].id.to_i

    expected_2 = "A LARGE yeti of SOrtS, casually devoURS a COw as the OTHERS WaTch NUmbly."

    result_2 = @ir.find_all_with_description(expected_2)

    assert_equal expected_1, result_2[0].description

    expected_3 = "Sales Engine is a relational database"

    result_3 = @ir.find_all_with_description(expected_3)

    assert_equal 0, result_3.length
  end

  def test_find_all_by_price_finds_all_items_matching_given_price
    result_1 = @ir.find_all_by_price(25)

    assert_equal 79, result_1.length

    result_2 = @ir.find_all_by_price(10)

    assert_equal 63, result_2.length

    result_3 = @ir.find_all_by_price(20000)

    assert_equal 0, result_3.length
  end

  def test_find_all_by_price_in_range_finds_all_items_matching_given_price_range
    result_1 = @ir.find_all_by_price_in_range(1000.00..1500.00)

    assert_equal 19, result_1.length

    result_2 = @ir.find_all_by_price_in_range(10.00..150.00)

    assert_equal 910, result_2.length

    result_3 = @ir.find_all_by_price_in_range(10.00..15.00)

    assert_equal 205, result_3.length

    result_4 = @ir.find_all_by_price_in_range(0.00..10.00)

    assert_equal 302, result_4.length
  end

  def test_find_all_by_merchant_id_returns_array_of_items_associated_with_given_merchant_id

    result_1 = @ir.find_all_by_merchant_id(12334326)

    assert_equal 6, result_1.length

    result_2 = @ir.find_all_by_merchant_id(12336020)

    assert_equal 2, result_2.length 
  end
end
