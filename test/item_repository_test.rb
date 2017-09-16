require_relative 'test_helper'
require './lib/sales_engine'
require 'csv'

class ItemRepositoryTest < Minitest::Test

  def setup
    item_file_path = './test/fixtures/items_truncated.csv'
    merchant_file_path = './test/fixtures/merchants_truncated.csv'
    invoice_file_path = './test/fixtures/invoices_truncated.csv'
    engine = SalesEngine.new(item_file_path, merchant_file_path, invoice_file_path)
    @repository = engine.items
  end


  def test_it_exists
    assert_instance_of ItemRepository, @repository
  end

  def test_it_creates_item_objects_for_each_row
    assert_instance_of Item, @repository.items.first
  end

  def test_all_returns_array_of_all_item_objects
    assert_equal 4, @repository.items.count
  end

  def test_find_by_id_returns_nil_if_no_id_found
    assert_nil(@repository.find_by_id(000000))
  end

  def test_find_by_id_returns_item_of_matching_id
    item = @repository.find_by_id(263395617)

    assert_equal 'Glitter scrabble frames', item.name

    item = @repository.find_by_id('263395617')

    assert_equal 'Glitter scrabble frames', item.name
  end

  def test_find_by_name_returns_nil_if_name_not_found
    assert_nil(@repository.find_by_name('scf'))
  end

  def test_find_by_name_returns_an_item_with_matching_name
    search_name = 'Glitter scrabble frames'
    item = @repository.find_by_name('Glitter scrabble frames')

    assert_equal 263395617, item.id

    item = @repository.find_by_name('glitter scrabble frames')

    assert_equal 263395617, item.id
  end

  def test_find_all_with_description
    assert_empty(@repository.find_all_with_description('asdf'))
  end

  def test_find_all_with_description_returns_all_matching_items
    items = @repository.find_all_with_description('glitter')

    assert_equal 2, items.count

    items = @repository.find_all_with_description('gli')

    assert_equal 2, items.count
  end

  def test_it_returns_empty_array_if_no_matching_price_is_found
    assert_empty(@repository.find_all_by_price(-1))
  end

  def test_it_finds_all_items_with_matching_price
    items = @repository.find_all_by_price(7)

    assert_equal 2, items.count
  end

  def test_it_returns_empty_array_if_no_match_by_price_range
      assert_empty(@repository.find_all_by_price_in_range(-2..-1))
  end

  def test_it_finds_all_by_price_in_range
    items = @repository.find_all_by_price_in_range(0..10)
    assert_equal 2, items.count
  end

  def test_it_finds_all_items_with_matching_merchant_id
    assert_empty(@repository.find_all_by_merchant_id(0))
  end

  def test_it_finds_all_items_with_matching_merchant_id
    items = @repository.find_all_by_merchant_id(12334185)

    assert_equal 3, items.count

    items = @repository.find_all_by_merchant_id('12334185')

    assert_equal 3, items.count
  end




end
