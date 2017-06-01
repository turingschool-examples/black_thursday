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

    assert_equal [ir.all[0]], ir.find_all_by_price(0.13E4)
    assert_equal [], ir.find_all_by_price(0.1515E2)
  end

  def test_find_all_by_price_in_range_returns_two_items
    ir = ItemRepository.new(@file_path)

    actual_1 = ir.find_all_by_price_in_range((1000..1400))
    actual_2 = ir.find_all_by_price_in_range((2500..2600))

    assert_equal [ir.all[0], ir.all[1]], actual_1
    assert_equal [], actual_2
  end
  #
  # def test_find_all_by_merchant_id
  #   ir = ItemRepository.new
  #   i1 = Item.new({:id         => 1,
  #                 :merchant_id => 11,
  #                 :name        => "Pencil",
  #                 :description => "You can use it to write things",
  #                 :unit_price  => BigDecimal.new(10.99,4),
  #                 :created_at  => Time.now,
  #                 :updated_at  => Time.now
  #                })
  #
  #   i2 = Item.new({:id         => 2,
  #                 :merchant_id => 11,
  #                 :name        => "Pen",
  #                 :description => "Empty",
  #                 :unit_price  => BigDecimal.new(11.99,4),
  #                 :created_at  => Time.now,
  #                 :updated_at  => Time.now
  #                })
  #   ir.all << i1
  #   ir.all << i2
  #
  #   actual_1 = ir.find_all_by_merchant_id(11)
  #   actual_2 = ir.find_all_by_merchant_id(12)
  #
  #   assert_equal [i1, i2], actual_1
  #   assert_equal [], actual_2
  #
  # end

end
