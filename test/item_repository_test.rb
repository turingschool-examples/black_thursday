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

  def test_it_can_be_found_by_name
    ir = ItemRepository.new("./data/mini_items.csv")
    assert ir.find_by_name("510+ realpush icon set")
  end

  def test_it_can_be_found_by_description
    ir = ItemRepository.new("./data/mini_items.csv")
    description = "Glitter scrabble frames"

    assert ir.find_all_with_description(description)
  end

  def test_find_all_by_price
    ir = ItemRepository.new("./data/mini_items.csv")
    assert ir.find_all_by_price(1300)
  end

  def test_it_can_find_all_by_price_in_range
    ir = ItemRepository.new("./data/mini_items.csv")
    assert ir.find_all_by_price_in_range(1..1200)
  end

end
