require 'minitest/autorun'
require 'minitest/pride'
require './lib/item_repository'
require 'pry'

class ItemRepositoryTest < Minitest::Test

  attr_reader :ir

  def setup
    @ir = ItemRepository.new('./data/items_test.csv')
  end

  def test_it_exists
    assert_instance_of ItemRepository, @ir
  end

  def test_load_csv
    assert_equal 3, @ir.items.length
    @ir.load_csv('./data/items_test.csv')

    assert_equal 6, @ir.items.length
  end

  def test_items_returns_array
    actual = @ir.items

    assert_instance_of Item, actual[0]
    assert_instance_of Item, actual[1]
    assert_instance_of Item, actual[2]
    assert_equal 3, actual.length
  end

  def test_all_returns_array_of_items
    actual = @ir.all

    assert_instance_of Item, actual[0]
    assert_instance_of Item, actual[1]
    assert_instance_of Item, actual[2]
    assert_equal 3, actual.length
  end

  def test_find_by_id_returns_nil_with_invalid_id
    actual = @ir.find_by_id(666)

    assert_nil actual
  end

  def test_find_by_id_returns_item_with_valid_id
    actual = @ir.find_by_id(263395237)
    expected = @ir.items[0]

    assert_equal expected, actual
  end

  def test_find_by_name_returns_nil_with_invalid_name
    actual = @ir.find_by_name("invalid")

    assert_nil actual
  end

  def test_find_by_name_returns_item_with_valid_name
    actual = @ir.find_by_name("510+ RealPush Icon Set")
    expected = @ir.items[0]

    assert_equal expected, actual
  end

  def test_find_by_name_returns_item_with_valid_name_case_insensitive
    actual = @ir.find_by_name("510+ realpush icon set")
    expected = @ir.items[0]

    assert_equal expected, actual
  end

  def test_find_all_with_description_returns_empty_array_with_invalid_search
    actual = @ir.find_all_by_description("people")

    assert_equal [], actual
  end

  def test_find_all_with_description_returns_items_with_valid_search_case_insensitive
    actual = @ir.find_all_by_description("Glitter")
    expected = [@ir.items[1], @ir.items[2]]

    assert_equal expected, actual
  end

  def test_find_all_by_price_returns_empty_array_with_invalid_search
    actual = @ir.find_all_by_price(199)

    assert_equal [], actual
  end

  def test_find_all_by_price_returns_item_with_valid_search
    actual = @ir.find_all_by_price(1200)
    expected = [@ir.items[0]]

    assert_equal expected, actual
  end

  def test_find_all_price_in_range_returns_empty_array_with_invalid_range
    actual = @ir.find_all_by_price_in_range((0..50))

    assert_equal [], actual
  end

  def test_find_all_by_price_in_range_returns_items_with_valid_range
    actual = @ir.find_all_by_price_in_range((1300..1350))
    expected = [@ir.items[1], @ir.items[2]]

    assert_equal expected, actual
  end





end
