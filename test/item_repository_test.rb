require './test/test_helper'
require './lib/sales_engine'
require './lib/item_repository'
require './lib/item'

class ItemRepositoryTest < Minitest::Test
  def setup
    @se = SalesEngine.from_csv({
      :merchants => "./data/merchants.csv",
      :items     => "./test/fixtures/items_truncated.csv",
      :customers => "./data/customers.csv",
      :invoices  => "./data/invoices.csv",
      :invoice_items => "./data/invoice_items.csv",
      :transactions  => "./data/transactions.csv"
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
    assert_equal 44, @ir.all.count
    assert_equal Item, @ir.all.first.class
  end

  def test_it_can_find_an_item_by_id
    item = @ir.find_by_id(263500440)
    assert_instance_of Item, item
  end

  def test_it_returns_nil_if_the_item_does_not_exist
    item = @ir.find_by_id(9658999956446)
    assert_nil item, 'non-existent item was supposed to return nil!'
  end

  def test_it_can_find_an_item_by_name
    item = @ir.find_by_name("Vogue Paris Original Givenchy 2307")
    assert_instance_of Item, item
  end

  def test_it_returns_nil_if_the_item_does_not_exist
    item = @ir.find_by_name("nfjsbvnvfsbvfs")
    assert_nil item, 'non-existent item was supposed to return nil!'
  end

  def test_the_item_by_name_search_is_case_insensitive
    item = @ir.find_by_name("vogue paris original givenchy 2307")
    assert_equal "Vogue Paris Original Givenchy 2307", item.name
  end

  def test_it_can_find_all_items_matching_description
    item = @ir.find_all_with_description("unlined hiplength jacket")
    assert_equal 1, item.count
  end

  def test_it_can_return_an_empty_array_if_no_matches_are_found
    item = @ir.find_all_with_description("vfjsbvsfv")
    assert_equal [], item
  end

  def test_all_matching_items_by_description_search_is_case_insensitive
    item = @ir.find_all_with_description("UNlined Hiplength Jacket")
    assert_equal 1, item.count
  end

  def test_it_can_find_all_items_matching_price
    item = @ir.find_all_by_price(100)
    assert_instance_of Item, item.first
  end

  def test_it_can_return_an_empty_array_if_no_matches_are_found
    item = @ir.find_all_by_price(5000000000)
    assert_equal [], item
  end

  def test_it_can_find_all_items_matching_price_range
    item = @ir.find_all_by_price_in_range(10..20)
    assert_instance_of Item, item.first
    assert_equal 6, item.count
  end

  def test_it_can_return_an_empty_array_if_no_matches_are_found
    item = @ir.find_all_by_price_in_range(0..0)
    assert_equal [], item
  end

  def test_it_can_find_all_items_matching_merchant_id_in_items
    item = @ir.find_all_by_merchant_id(12334123)
    assert_instance_of Item, item.first
  end

  def test_it_can_return_an_empty_array_if_no_matches_are_found
    item = @ir.find_all_by_merchant_id(90907653)
    assert_equal [], item
  end
end
