require_relative 'test_helper.rb'
require_relative '../lib/item_repository'

class ItemRepositoryTest < Minitest::Test
  attr_reader :ir

  def setup
    @ir = ItemRepository.new("./test/fixtures/items_test.csv")
  end

  def test_it_exists
    assert_instance_of ItemRepository, ir
  end

  def test_it_creates_new_instances_of_item
    assert_instance_of Item, ir.all.first
    assert_equal "Glitter scrabble frames", ir.all.first.name
  end

  def test_it_returns_all_instances_of_item
    assert_equal 7, ir.all.count
  end

  def test_it_can_find_by_id
    assert_instance_of Item, ir.find_by_id(263394417)
    assert_equal "DINO EGGS", ir.find_by_id(263394417).name
  end

  def test_it_returns_nil_if_it_does_not_find_id_number
    assert_nil ir.find_by_id(26339523799933)
  end

  def test_it_can_find_by_name
    assert_instance_of Item, ir.find_by_name("SQUIRREL!")
    assert_equal 263454779, ir.find_by_name("SQUIRREL!").id
  end

  def test_it_knows_name_case_insensitive
    assert_equal 263394417, ir.find_by_name("DinO egGS").id
  end

  def test_it_returns_nil_if_it_does_not_find_name
    assert_nil ir.find_by_name("target")
  end

  def test_it_can_find_all_descriptions_that_match_supplied_fragment
    assert_instance_of Item, ir.find_all_with_description("waa").first
    assert_equal 2, ir.find_all_with_description("waa").count
    assert_equal 263395617, ir.find_all_with_description("waa").first.id
  end

  def test_find_by_description_is_case_insensitive
    assert_equal 263395617, ir.find_all_with_description("GLITTER").first.id
  end

  def test_find_by_description_returns_empty_array_if_no_matches
    assert_equal [], ir.find_all_with_description("rrrrrrrr")
  end

  def test_it_returns_instance_of_item_when_supplied_with_price
    assert_instance_of Item, ir.find_all_by_price(100.99).first
    assert_equal "DINO EGGS", ir.find_all_by_price(100.99).first.name
    assert_equal "Glitter scrabble frames", ir.find_all_by_price(94.80).first.name
  end


  def test_find_by_price_returns_empty_array_if_no_matches
    assert_equal [], ir.find_all_by_price("rrrrrrrr")
  end

  def test_it_finds_all_in_price_range
    assert_equal 4, ir.find_all_by_price_in_range((95..100)).count
  end

  def test_find_all_in_price_range_returns_empty_array_if_no_matches
    assert_equal [], ir.find_all_by_price_in_range((1..10))
  end

  def test_it_finds_one_by_merchant_id
    assert_instance_of Item, ir.find_all_by_merchant_id(12334185).first
    assert_equal "DINO EGGS", ir.find_all_by_merchant_id(12334185).last.name
  end

  def test_it_finds_all_by_merchant_id
    assert_instance_of Item, ir.find_all_by_merchant_id(12334185).first
    assert_equal 2, ir.find_all_by_merchant_id(12334185).count
    assert_equal "Glitter scrabble frames", ir.find_all_by_merchant_id(12334185).first.name
  end

  def test_it_returns_empty_array_when_merchant_id_not_found
    assert_equal [], ir.find_all_by_merchant_id("rrrrrrrr")
  end


end
