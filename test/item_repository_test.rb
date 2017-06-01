require 'minitest/autorun'
require 'minitest/pride'
require './lib/item_repository'
require './lib/item'
require 'pry'


class ItemRepositoryTest < MiniTest::Test


  def test_it_can_find_by_id
    ir = ItemRepository.new('./test/data/items_fixture.csv')
    id = 263395237
    item = ir.find_by_id(id)

    assert_equal item.id, id
    assert_instance_of Item, item
  end

  # def test_if_can_find_by_name
  #   ir = ItemRepository.new
  #   ir.add_items(item_1)
  #   ir.add_items(item_2)
  #
  #   assert_equal item_2, ir.find_by_name("McDonalds")
  # end
  #
  # def test_to_find_all_with_description
  #   ir = ItemRepository.new
  #   ir.add_items(item_1)
  #   ir.add_items(item_2)
  #   results = ir.find_all_with_descriptions("Best burgers ever here")
  #
  #   assert results.include?(item_1)
  # end
  #
  # def test_if_can_find_all_by_price
  #   ir = ItemRepository.new
  #   ir.add_items(item_1)
  #   ir.add_items(item_2)
  #   results = ir.find_all_by_price(10)
  #
  #   assert results.include?(item_2)
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
