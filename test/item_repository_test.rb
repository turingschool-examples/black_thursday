require './test/test_helper'
require './lib/item_repository'
require 'csv'

class ItemRepositoryTest < Minitest::Test
  attr_reader :ir

  def setup
    fixture = CSV.open('./test/fixtures/items_fixture.csv',
                          headers: true,
                          header_converters: :symbol)
    csv_rows = fixture.to_a
    @ir = ItemRepository.new(csv_rows)
  end

  def test_method_items_returns_array_of_items
    assert_instance_of Array, ir.items
    assert_equal true, ir.items.all? { |thing| thing.class == Item }
  end

  def test_method_all_returns_array_of_items
    assert_equal ir.items, ir.all
  end

  def test_method_find_by_id_returns_nil_or_item
    item =     ir.find_by_id(1)
    item_nil = ir.find_by_id('googleypuff')
    assert_instance_of Item, item
    assert_equal 1,          item.id
    assert_equal nil,        item_nil
  end

  def test_method_find_by_name_returns_nil_or_item
    item_lowercase = ir.find_by_name("name a")
    item_uppercase = ir.find_by_name("NAME A")
    item_nil =       ir.find_by_name("Donkey the dinosaur part 2")
    assert_instance_of Item, item_lowercase
    assert_equal "name a",   item_lowercase.name
    assert_equal "name a",   item_uppercase.name
    assert_equal nil,        item_nil
  end

  def test_method_find_all_with_description_returns_array_of_items
    items =               ir.find_all_with_description("description a")
    items_multiple = ir.find_all_with_description("dESCrIPTioN")
    items_empty =         ir.find_all_with_description("nothing here")
    assert_instance_of Array, items
    assert_equal ir.items[0], items[0]
    assert_equal true,        items_multiple.length > 1
    assert_equal [],          items_empty
  end

  def test_method_find_all_by_price_returns_array_of_items
    items =           ir.find_all_by_price(1.00)
    items_empty =     ir.find_all_by_price(12345679.10)
    items_multiple =  ir.find_all_by_price(1.99)
    assert_equal ir.items[0].unit_price, items[0].unit_price
    assert_equal [],                     items_empty
    assert_equal true,                   items_multiple.length > 1
  end

  def test_method_find_all_by_price_in_range_returns_array_of_items
    items_multiple = ir.find_all_by_price_in_range(1..2)
    items_empty =    ir.find_all_by_price_in_range(9000..9001)
    assert_equal true, items_multiple.length > 1
    assert_equal [],   items_empty
  end
#
  def test_method_find_all_by_merchant_id_returns_array_of_items
    items = ir.find_all_by_merchant_id(1000)
    items_multiple = ir.find_all_by_merchant_id(1001)
    items_empty = ir.find_all_by_merchant_id(9000..9001)
    assert_equal ir.items[0], items[0]
    assert_equal true, items_multiple.length > 1
    assert_equal [], items_empty
  end

  def test_method_find_merchant_by_id_returns_merchant
    mock_se = Minitest::Mock.new
    ir = ItemRepository.new([], mock_se)
    mock_se.expect(:find_merchant_by_id, nil, [1000])
    ir.find_merchant_by_id(1000)
    assert mock_se.verify
  end
end
