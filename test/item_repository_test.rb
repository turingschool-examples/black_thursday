require 'pry'
require_relative 'test_helper'
require_relative '../lib/item_repository'
require_relative '../lib/item'

class ItemRepositoryTest < MiniTest::Test

  def setup
    @file_path = './test/data/items_test.csv'
  end

  def test_if_create_class
    ir = ItemRepository.new(@file_path)

    assert_instance_of ItemRepository, ir
  end

  def test_initialize_and_population_of_items
    ir = ItemRepository.new(@file_path)

    assert_equal 5, ir.all.length
  end

  def test_if_find_by_id_returns_correct_value_for_method
    ir = ItemRepository.new(@file_path)

    assert_equal ir.all[0], ir.find_by_id(263395617)
    assert_nil ir.find_by_id(3)
  end

  def test_find_by_name_returns_correct_value_for_method
    ir = ItemRepository.new(@file_path)

    assert_equal ir.all[0], ir.find_by_name('Glitter scrabble frames')
    assert_nil ir.find_by_name('Crayon')
  end

  def test_find_all_with_description_returns_correct_value_for_method
    ir = ItemRepository.new(@file_path)


    actual_1 = ir.find_all_with_description("glitter")
    actual_2 = ir.find_all_with_description("This description doesn't exist")
    assert_equal [ir.all[0], ir.all[1]], actual_1
    assert_equal [], actual_2
  end

  def test_find_all_by_price
    ir = ItemRepository.new(@file_path)

    assert_equal [ir.all[0]], ir.find_all_by_price(13)
    assert_equal [], ir.find_all_by_price(0.1515E2)
  end

  def test_find_all_by_price_in_range_returns_two_items
    ir = ItemRepository.new(@file_path)

    actual_1 = ir.find_all_by_price_in_range((10.00..14.00))
    actual_2 = ir.find_all_by_price_in_range((25.00..26.00))

    assert_equal [ir.all[0], ir.all[1]], actual_1
    assert_equal [], actual_2
  end

  def test_find_all_by_merchant_id
    ir = ItemRepository.new(@file_path)

    actual_1 = ir.find_all_by_merchant_id(12334185)
    actual_2 = ir.find_all_by_merchant_id(12)

    assert_equal [ir.all[0], ir.all[1], ir.all[2]], actual_1
    assert_equal [], actual_2
  end

end
