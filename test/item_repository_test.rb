require './lib/item'
require 'minitest/autorun'
require 'minitest/pride'
require 'pry'


class ItemRepositoryTest < Minitest::Test

  def setup
    @ir = ItemRepository.new("./data/items.csv")
  end

  def test_it_exists
    assert_instance_of ItemRepository, @ir
  end

  def test_all_returns_all_items_in_the_correct_format
    assert_instance_of Item, @ir.items[0]
    assert_equal "510+ RealPush Icon Set", @ir.items[0].name
    assert_equal 263395237, @ir.items[0].id
    assert_equal 1367, @ir.items.count
  end

  def test_it_returns_all
    all_items = @ir.all
    assert_equal 1367, all_items.count
  end

  def test_it_can_find_by_id
    item = @ir.find_by_id(263395237)
    nil_item = @ir.find_by_id(201)

    assert_equal "510+ RealPush Icon Set", item.name
    assert_nil nil_item
  end

  def test_it_has_a_name
    item = @ir.find_by_name("510+ RealPush Icon Set")
    nil_item = @ir.find_by_name("The Pencil")

    assert_equal 263395237, item.id
    assert_nil nil_item
  end

  def test_it_can_find_all_with_description
    items = @ir.find_all_with_description('beer')

    assert_equal 3, items.count
    assert items[0].description.include?('beer')
    assert items[2].description.include?('beer')
  end

  def test_it_can_find_all_by_price
    items = @ir.find_all_by_price(50000)

    assert_equal 11, items.count
    assert_equal 50000, items[0].unit_price
    assert_equal 50000, items[7].unit_price
  end

  def test_it_finds_all_by_price_in_range
    price_range = Range.new(47000,50000)
    price_range_items = @ir.find_all_by_price_in_range(price_range)

    assert_equal 13, price_range_items.count
    assert price_range_items[0].unit_price >= 47000 && price_range_items[0].unit_price <= 50000
  end

  def test_it_finds_all_by_merchant_id
    items = @ir.find_all_by_merchant_id(12334132)
    empty_items = @ir.find_all_by_merchant_id(90210878)

    assert_equal 3, items.count
    assert_equal 12334132, items[0].merchant_id
    assert_equal 12334132, items[2].merchant_id
    assert_equal [], empty_items
  end

end
