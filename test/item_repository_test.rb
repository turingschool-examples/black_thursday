require_relative 'test_helper'
require './lib/item_repository'

class ItemRepositoryTest < MiniTest::Test

  def test_it_exists
    ir = ItemRepository.new

    assert_instance_of ItemRepository, ir
  end

  def test_all_returns_all_items_in_array
    ir = ItemRepository.new
    ir.populate('test/fixtures/items_fixture.csv')

    assert_instance_of Array, ir.all
    assert_instance_of Item, ir.all.first
    assert_equal 5, ir.all.count
  end

  def test_it_can_find_item_by_id
    ir = ItemRepository.new
    ir.populate('test/fixtures/items_fixture.csv')

    assert_instance_of Item, ir.find_by_id(4)
    assert_nil ir.find_by_id(1000)
  end

  def test_IR_can_find_item_by_name
    ir = ItemRepository.new
    ir.populate('test/fixtures/items_fixture.csv')

    assert_instance_of Item, ir.find_by_name("   Zoom super FLukE  ")
    assert_nil ir.find_by_name("HELLO WorlD!!")
  end

  def test_IR_can_find_items_with_some_text_in_description
    ir = ItemRepository.new
    ir.populate('test/fixtures/items_fixture.csv')

    assert_instance_of Array, ir.find_all_with_description("fish  ")
    assert_instance_of Item, ir.find_all_with_description("fish").first
    assert_equal 3, ir.find_all_with_description("fish").count
    assert_equal [], ir.find_all_with_description("Hello World")
  end

  def test_IR_can_find_all_items_with_price
    ir = ItemRepository.new
    ir.populate('test/fixtures/items_fixture.csv')

    assert_equal 1, ir.find_all_by_price(0.15e0).count
    assert_equal [], ir.find_all_by_price(100000)
  end

  def test_IR_can_find_items_within_price_range
    ir = ItemRepository.new
    ir.populate('test/fixtures/items_fixture.csv')

    assert_equal [], ir.find_all_by_price_in_range((10000..20000))
    assert_equal 5, ir.find_all_by_price_in_range((0.3e-1..0.25e0)).count

  end

  def test_IR_can_find_all_items_by_merchant_ID
    ir = ItemRepository.new
    ir.populate('test/fixtures/items_fixture.csv')

    assert_equal [], ir.find_all_by_merchant_id(100008)
    assert_equal 1, ir.find_all_by_merchant_id(898).count
  end

end
