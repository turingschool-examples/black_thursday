# frozen_string_literal: true

require 'simplecov'
SimpleCov.start

require 'minitest/autorun'
require 'minitest/pride'
require 'bigdecimal'

require './lib/item'
require './lib/item_repository'

# Item repository class
class ItemRepositoryTest < Minitest::Test
  def setup
    @ir = ItemRepository.new
    @item1 = @ir.create(
      id:          1,
      name:        'Pencil',
      description: 'You can use it to write things',
      unit_price:  BigDecimal(10.00, 4),
      created_at:  Time.now,
      updated_at:  Time.now,
      merchant_id: 4
    )
    @item2 = @ir.create(
      id:          2,
      name:        'Book',
      description: 'You can use it to learn things',
      unit_price:  BigDecimal(10.00, 4),
      created_at:  Time.now,
      updated_at:  Time.now,
      merchant_id: 5
    )
    @item3 = @ir.create( # this one has no :id
      name:        'Pencil Sharpener',
      description: 'You can use it to sharpen pencils',
      unit_price:  BigDecimal(13.99, 4),
      created_at:  Time.now,
      updated_at:  Time.now,
      merchant_id: 6
    )
  end

  def test_it_exists
    assert_instance_of ItemRepository, @ir
  end

  def test_it_creates_new_item_instance
    assert_instance_of Item, @item1
  end

  def test_it_returns_array_of_all_item_instances
    expected = {
      1 => @item1,
      2 => @item2,
      3 => @item3
    }
    assert_equal expected, @ir.all
  end

  def test_it_can_find_by_id
    assert_equal @item1, @ir.find_by_id(1)
  end

  def test_it_can_find_by_name
    assert_equal @item1, @ir.find_by_name('Pencil')
  end

  def test_it_finds_all_with_description
    assert_equal [@item1, @item2], @ir.find_all_with_description('things')
  end

  def test_it_finds_all_by_price

    assert_equal [@item1, @item2], @ir.find_all_by_price(10.00)
  end

  def test_it_finds_all_by_price_in_range

    assert_equal [@item1, @item2, @item3], @ir.find_all_by_price_in_range(10..15)
    assert_equal [], @ir.find_all_by_price_in_range(2..5)
  end
end
