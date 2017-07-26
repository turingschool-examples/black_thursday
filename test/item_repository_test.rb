require_relative 'test_helper'
require './lib/item_repository'
require 'pry'

class ItemRepositoryTest < Minitest::Test

  def test_it_exitst
    ir = ItemRepository.new("./data/mini_items.csv")
    assert_instance_of ItemRepository, ir
  end

  def test_it_can_load_csv_file
    ir = ItemRepository.new("./data/items.csv")
    assert ir
  end

  def test_it_can_return_array_of_items
    ir = ItemRepository.new("./data/mini_items.csv")
    assert_equal 2, ir.all.count
  end

  def test_it_can_find_by_id
    ir = ItemRepository.new("./data/mini_items.csv")
    assert ir.find_by_id(263395237)
  end

  def test_it_returns_nil_if_no_id_is_found
    ir = ItemRepository.new("./data/mini_items.csv")
    assert_nil ir.find_by_id(12334213)
  end

  def test_it_can_be_found_by_name
    ir = ItemRepository.new("./data/mini_items.csv")
    assert ir.find_by_name("510+ realpush icon set")
  end

  def test_it_can_be_found_by_another_name
    ir = ItemRepository.new("./data/items.csv")
    assert ir.find_by_name("Sunstone Pendant!")
  end

  def test_it_returns_nil_if_no_name_is_found
    ir = ItemRepository.new("./data/mini_items.csv")
    assert_nil ir.find_by_name("Vogue Paris Original Givenchy 2307")
  end

  def test_it_can_be_found_by_description
    ir = ItemRepository.new("./data/mini_items.csv")
    description = "Glitter scrabble frames"

    assert ir.find_all_with_description(description)
  end

  def test_it_returns_an_empty_array_if_no_description_matches
    ir = ItemRepository.new("./data/mini_items.csv")
    description = "A Variety of Fragrance Oils for Oil Burners"
    expected = []

    assert_equal expected, ir.find_all_with_description(description)
  end

  def test_find_all_by_price
    ir = ItemRepository.new("./data/mini_items.csv")
    assert ir.find_all_by_price(1300)
  end

  def test_it_returns_an_empty_array_if_no_price_matches
    ir = ItemRepository.new("./data/mini_items.csv")
    expected = []

    assert_equal expected, ir.find_all_by_price(1400)
  end

  def test_it_can_find_all_by_price_in_range
    ir = ItemRepository.new("./data/mini_items.csv")
    assert ir.find_all_by_price_in_range(1..1200)
  end

  def test_it_returns_an_empty_array_if_no_price_in_range
    ir = ItemRepository.new("./data/mini_items.csv")
    expected = []

    assert_equal expected, ir.find_all_by_price_in_range(1400..1600)
  end

  def test_it_can_find_all_by_merchant_id
    ir = ItemRepository.new("./data/mini_items.csv")
    assert ir.find_all_by_merchant_id(12334185)
  end

  def test_it_returns_an_empty_array_if_it_cant_find_merchant_id
    ir = ItemRepository.new("./data/mini_items.csv")
    expected = []

    assert_equal expected, ir.find_all_by_merchant_id(12334207)
  end

end
