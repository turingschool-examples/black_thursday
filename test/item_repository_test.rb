require './test/test_helper'
require './lib/sales_engine'
require './lib/item_repository'
require './lib/item'

class ItemRepositoryTest < Minitest::Test
  def setup
    @se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv"
      })

    @ir = @se.items
  end

  def test_it_can_load_csv
    assert_instance_of CSV, @ir.csv
  end

  def test_it_can_create_instance_of_item
    assert_instance_of Item, @ir.all.first
  end

  def test_all_returns_an_array
    assert_instance_of Array, @ir.all
  end

  def test_all_contains_proper_number_of_items
    assert_equal 1367, @ir.all.count
    assert_equal Item, @ir.all.first.class
  end

  def test_it_can_find_an_item_by_id
    item = @ir.find_by_id(263395617)
    assert_instance_of Item, item
  end

  def test_it_returns_nil_if_the_item_does_not_exist
    item = @ir.find_by_id(9658999956446)
    assert_nil item, 'non-existent item was supposed to return nil!'
  end

  def test_it_can_find_an_item_by_name
    item = @ir.find_by_name("Green Footed Ceramic Bowl")
    assert_instance_of Item, item
  end

  def test_it_returns_nil_if_the_item_does_not_exist
    item = @ir.find_by_name("nfjsbvnvfsbvfs")
    assert_nil item, 'non-existent item was supposed to return nil!'
  end

  def test_the_item_by_name_search_is_case_insensitive
    item = @ir.find_by_name("grEEn fooTED ceRamic bOWl")
    assert_equal "Green Footed Ceramic Bowl", item.name
  end

  def test_it_can_find_all_items_matching_description
    item = @ir.find_all_with_description("little natural crazing")
    assert_equal 1, item.count
  end

  def test_it_can_return_an_empty_array_if_no_matches_are_found
    item = @ir.find_all_with_description("vfjsbvsfv")
    assert_equal [], item
  end

  def test_all_matching_items_by_description_search_is_case_insensitive
    item = @ir.find_all_with_description("liTTle nATUral CraZing")
    assert_equal 1, item.count
  end

  def test_it_can_find_all_items_matching_price
    item = @ir.find_all_by_price(1350)
    assert_instance_of Item, item.first
  end

  def test_it_can_return_an_empty_array_if_no_matches_are_found
    item = @ir.find_all_by_price(5000000000)
    assert_equal [], item
  end

  def test_it_can_find_all_items_matching_price_range
    item = @ir.find_all_by_price_in_range(1000..2000)
    assert_instance_of Item, item.first
    assert_equal 317, item.count
    #unsure of range format being passed in
  end

  def test_it_can_return_an_empty_array_if_no_matches_are_found
    item = @ir.find_all_by_price_in_range(0..0)
    assert_equal [], item
    #unsure of range format being passed in
  end

  def test_it_can_find_all_items_matching_merchant_id_in_items
    item = @ir.find_all_by_merchant_id(12334195)
    assert_instance_of Item, item.first
  end

  def test_it_can_return_an_empty_array_if_no_matches_are_found
    item = @ir.find_all_by_merchant_id(90907653)
    assert_equal [], item
  end
end
