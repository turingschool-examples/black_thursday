require './test/test_helper'
require_relative '../lib/item_repository'
require_relative '../lib/item'
require 'pry'


class ItemRepositoryTest < MiniTest::Test

  def test_it_can_find_by_id
    ir = ItemRepository.new('./test/data/items_fixture.csv', sales_engine = nil)
    id = 263395237
    item = ir.find_by_id(id)

    assert_equal item.id, id
    assert_instance_of Item, item
  end

  def test_if_can_find_by_name
    ir = ItemRepository.new('./test/data/items_fixture.csv', sales_engine = nil)
    item = ir.find_by_name("Glitter scrabble frames")

    assert_equal "Glitter scrabble frames", item.name
  end

  def test_if_can_find_all_by_price
    ir = ItemRepository.new('./test/data/items_fixture.csv', sales_engine = nil)

    assert_equal 1, ir.find_all_by_price(12.00).length
  end

  def test_it_can_find_all_with_description
    ir  = ItemRepository.new("./test/data/items_fixture.csv", sales_engine = nil)

    assert_equal 2, ir.find_all_with_description("glitter").length
  end

  def test_items_find_by_all_price
    ir  = ItemRepository.new("./test/data/items_fixture.csv", sales_engine = nil)

    assert_equal 1, ir.find_all_by_price(12).length
  end

  def test_find_all_by_price_in_range
    ir  = ItemRepository.new("./test/data/items_fixture.csv", sales_engine = nil)

    assert_equal 1, ir.find_all_by_price_in_range(5...13).length
  end

  def test_if_can_find_all_by_merchant_id
    ir  = ItemRepository.new("./test/data/items_fixture.csv", sales_engine = nil)

    assert_equal 1, ir.find_all_by_merchant_id(12334141).length
  end

end
