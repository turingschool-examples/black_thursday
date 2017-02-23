require 'test_helper'
require './lib/item_repository'

class ItemRepositoryTest < Minitest::Test

  def test_it_exists
    # se = SalesEngine.from_csv({
    #   :items     => "./data/items.csv",
    #   :merchants => "./data/merchants.csv"})
    #
    # ir   = se.items
    # item = ir.find_by_name("Item Repellat Dolorum")
    #   # => <Item>
  end

  def test_it_returns_an_array_of_all_item_instances
    # method #all
    # returns an array of all known Item instances
  end

  def test_it_can_find_an_item_by_id
    # method #find_by_id
    # returns either nil or an instance of Item with a matching ID
  end

  def test_it_returns_nil_if_the_item_does_not_exist
    # method #find_by_id
    # returns either nil or an instance of Item with a matching ID
  end

  def test_it_can_find_an_item_by_name
    # method #find_by_name
    # returns either nil or an instance of Item having done a case insensitive search
  end

  def test_the_item_by_name_search_is_case_insensitive
    # method #find_by_name
    # returns either nil or an instance of Item having done a case insensitive search
  end

  def test_it_returns_nil_if_the_item_does_not_exist
    # method #find_by_name
    # returns either nil or an instance of Item having done a case insensitive search
  end

  def test_it_can_find_all_items_matching_description
    # method #find_all_with_description
    # returns either [] or instances of Item where the supplied string appears in the item description (case insensitive)
  end

  def test_it_can_return_an_empty_array_if_no_matches_are_found
    # method #find_all_with_description
    # returns either [] or instances of Item where the supplied string appears in the item description (case insensitive)
  end

  def test_all_matching_items_by_description_search_is_case_insensitive
    # method #find_all_with_description
    # returns either [] or instances of Item where the supplied string appears in the item description (case insensitive)
  end

  def test_it_can_find_all_items_matching_price
    # method #find_all_by_price
    # returns either [] or instances of Item where the supplied price exactly matches
  end

  def test_it_can_return_an_empty_array_if_no_matches_are_found
    # method #find_all_by_price
    # returns either [] or instances of Item where the supplied price exactly matches
  end

  def test_it_can_find_all_items_matching_price_range
    # method #find_all_by_price_in_range
    # returns either [] or instances of Item where the supplied price is in the supplied range (a single Ruby range instance is passed in)
  end

  def test_it_can_return_an_empty_array_if_no_matches_are_found
    # method #find_all_by_price_in_range
    # returns either [] or instances of Item where the supplied price is in the supplied range (a single Ruby range instance is passed in)
  end

  def test_it_can_find_all_items_matching_merchant_id
    # method #find_all_by_merchant_id
    # returns either [] or instances of Item where the supplied merchant ID matches that supplied
  end

  def test_it_can_return_an_empty_array_if_no_matches_are_found
    # method #find_all_by_merchant_id
    # returns either [] or instances of Item where the supplied merchant ID matches that supplied
  end
end
