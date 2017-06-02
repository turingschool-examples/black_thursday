require 'minitest/autorun'
require 'minitest/pride'
require './lib/item_repository'
require './lib/item'
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

    assert_equal 1, ir.find_all_by_price(1200).length
  end

  # def test_items_searched_by_all_price
  #   se = SalesEngine.from_csv({
  #   :items     => "./data/items.csv",
  #   :merchants => "./data/merchants.csv"})
  #   items = se.items
  #
  #   assert_equal 6, items.find_all_by_price(300).length
  #   refute_equal 2, items.find_all_by_price(300).length
  # end
  #
  # def test_if_can_find_all_by_price_in_range
  #   ir = ItemRepository.new
  #   ir.add_items(item_1)
  #   ir.add_items(item_2)
  #   results = ir.find_all_by_price_in_range(5..15)
  #
  #   assert results.include?(item_1)
  #   assert results.include?(item_2)
  # end
  #
  # def test_if_can_find_all_by_merchant_id
  #   ir = ItemRepository.new
  #   ir.add_items(item_1)
  #   ir.add_items(item_2)
  #   results = ir.find_all_by_merchant_id(123)
  #
  #   assert results.include?(item_1)
  # end

end
