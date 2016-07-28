require './test/test_helper'
require './lib/item_repository'
require './lib/item'
require './lib/sales_engine'
require 'csv'

class ItemRepositoryTest < Minitest::Test
  attr_reader :ir, :se, :ir2

  def setup
    items_file = CSV.open("./test/testdata/items_simple.csv",
                          headers: true,
                          header_converters: :symbol)
    csv_rows = items_file.to_a
    @ir = ItemRepository.new(csv_rows, se)

    @se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./test/testdata/merchants_simple.csv",
    })
    @ir2 = se.items
  end

  def test_items_is_an_array_of_item_instances
    assert_equal Array, ir.items.class
    assert_equal true, ir.items.all? { |thing| thing.class == Item }
  end

  def test_item_is_instantiated_with_correct_attributes
    assert_equal 263415269, ir.items[0].id
    assert_equal "name a", ir.items[0].name
    assert_equal "desc a", ir.items[0].description
    assert_equal BigDecimal(2799 / 100.0, 4), ir.items[0].unit_price
    assert_equal 12334181, ir.items[0].merchant_id
    assert_equal Time.parse('2016-01-11 15:11:05 UTC'), ir.items[0].created_at
    assert_equal Time.parse('2016-01-12 15:41:05 UTC'), ir.items[0].updated_at
  end

  def test_method_all_returns_array_known_item_instances
    assert_equal ir.items, ir.all
  end

  def test_method_find_by_id_returns_nil_or_item_instance
    item_1 = ir.find_by_id(263415269)
    item_2 = ir.find_by_id('googleypuff')
    assert_equal Item, item_1.class
    assert_equal 263415269, item_1.id
    assert_equal nil, item_2
  end

  def test_method_find_by_name_returns_nil_or_item_instance
    item_1 = ir.find_by_name("name o")
    item_2 = ir.find_by_name("NAME o")
    item_3 = ir.find_by_name("Donkey the dinosaur part 2")
    assert_equal Item, item_1.class
    assert_equal "name o", item_1.name
    assert_equal "name o", item_2.name
    assert_equal nil, item_3
  end

  def test_method_find_all_with_description_returns_array_of_matches
    desc_1 = "desc a"
    desc_2 = "dEsc"
    desc_3 = "nothing here"
    items_1 = ir.find_all_with_description(desc_1)
    items_2 = ir.find_all_with_description(desc_2)
    items_3 = ir.find_all_with_description(desc_3)
    assert_equal Array, items_1.class
    assert_equal 1, items_1.length
    assert_equal Array, items_2.class
    assert_equal 26, items_2.length
    assert_equal [], items_3
  end

  def test_method_find_all_by_price_returns_array_of_matches
    price_1 = ir.find_all_by_price(31.99)
    price_2 = ir.find_all_by_price(5890.76)
    price_3 = ir.find_all_by_price(51.99)
    assert_equal 31.99, price_1[0].unit_price
    assert_equal [], price_2
    assert_equal 2, price_3.length
  end

  def test_method_find_all_by_price_in_range_returns_array_of_matches
    range_1 = ir.find_all_by_price_in_range(27..30)
    range_2 = ir.find_all_by_price_in_range(1000..1001)
    assert_equal 3, range_1.length
    assert_equal [], range_2
  end

  def test_method_find_all_by_merchant_id_returns_array_of_matches
    mercs_1 = ir.find_all_by_merchant_id(12334200)
    mercs_2 = ir.find_all_by_merchant_id(12334204)
    mercs_3 = ir.find_all_by_merchant_id(12339999)
    assert_equal 1, mercs_1.length
    assert_equal 3, mercs_2.length
    assert_equal [], mercs_3
  end

  def test_method_find_merchant_by_id
    merchant = se.find_merchant_by_id(12334149)
    assert_equal merchant, ir2.find_merchant_by_id(12334149)
  end
end
