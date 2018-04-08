# frozen_string_literal: true

require 'simplecov'
SimpleCov.start
require 'minitest'
require 'minitest/emoji'
require 'minitest/autorun'
require './lib/item_repository.rb'
require './lib/sales_engine.rb'
require 'pry'

# Tests the functionality of the item repository
class ItemRepositoryTest < Minitest::Test
  attr_reader :items

  def setup
    se = SalesEngine.from_csv({:items => './fixtures/items_test.csv'})
    @items = se.items
  end

  def test_item_repository_exists
    assert_instance_of ItemRepository, @items
  end

  def test_all_returns_all_items
    assert_equal 5, @items.all.length
  end

  def test_it_finds_item_by_id
    id = 263399187
    expected = @items.find_by_id(id)

    assert_equal 263399187, expected.id
    assert_equal "Spalted Maple Heart Box", expected.name
  end

  def test_it_returns_nil_for_invalid_id
    expected = @items.find_by_id(1)

    assert_nil expected
  end

  def test_it_finds_item_by_name
    expected = @items.find_by_name('Matrice monolithique')

    assert_equal 'Matrice monolithique', expected.name
    assert_equal 263399263, expected.id
  end

  def test_it_finds_item_by_description
    expected = @items.find_all_with_description('badass batman themed watch')

    assert_equal 34567, expected.first.id
    assert_equal 'badass batman themed watch', expected.first.description
  end

  def test_it_finds_all_matching_items_by_price
    expected = @items.find_all_by_price(600.00)

    assert_instance_of Array, expected
    assert_equal 1, expected.length
  end

  def test_it_finds_all_within_price_range
    expected = @items.find_all_by_price_in_range(11.99..50.00)

    assert_instance_of Array, expected
    assert_equal 4, expected.length
  end

  def test_find_all_merchant_items_by_id
    expected = @items.find_all_by_merchant_id(92929)

    assert_instance_of Array, expected
    assert_equal 2, expected.length
  end
end
