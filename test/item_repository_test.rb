# frozen_string_literal: true

require 'simplecov'
SimpleCov.start
require './lib/item_repository.rb'
require './lib/sales_engine.rb'
require 'minitest'
require 'minitest/autorun'
require 'minitest/emoji'
require 'pry'

# Tests the functionality of the item repository
class ItemRepositoryTest < Minitest::Test
  attr_reader :items

  def setup
    se = SalesEngine.from_csv({:items => './fixtures/items_test.csv'})
    @items = se.items
  end

  def test_item_repository_exists
    assert_instance_of ItemRepository, items
  end

  def test_all_returns_all_items
    assert_equal 5, items.all.length
  end

  def test_it_finds_item_by_id
    expected = items.find_by_id(263399187)

    assert_equal 263399187, expected.id
    assert_equal "Spalted Maple Heart Box", expected.name
  end

  def test_it_returns_nil_for_invalid_id
    expected = items.find_by_id(1)

    assert_nil expected
  end

  def test_it_finds_item_by_name
    expected = items.find_by_name('Matrice monolithique')

    assert_equal 'Matrice monolithique', expected.name
    assert_equal 263399263, expected.id
  end

  def test_it_returns_empty_array_when_description_has_no_match
    expected = items.find_all_with_description('weasel watch')

    assert_nil expected
  end

  def test_it_finds_item_by_description
    expected = items.find_all_with_description('badass batman themed watch')

    assert_equal 34567, expected.first.id
    assert_equal 'badass batman themed watch', expected.first.description
  end

  def test_it_finds_all_matching_items_by_price
    expected = items.find_all_by_price(BigDecimal(600))

    assert_instance_of Array, expected
    assert_equal 1, expected.length
  end

  def test_it_finds_all_within_price_range
    expected = items.find_all_by_price_in_range(11.99..50.00)

    assert_instance_of Array, expected
    assert_equal 4, expected.length
  end


  def test_find_all_merchant_items_by_id
    expected = items.find_all_by_merchant_id(92929)

    assert_instance_of Array, expected
    assert_equal 2, expected.length
  end

  def test_it_can_create_a_new_item
    expected = items.create({
      id: '263395721',
      name: 'Disney scrabble frames',
      description: 'Disney glitter frames Any colour glitter available and can do any characters you require',
      unit_price: '1350',
      merchant_id: '12334185',
      created_at: '2016-01-11 11:51:37 UTC',
      updated_at: '2008-04-02 13:48:57 UTC' })

    assert_instance_of Hash, expected
    assert_equal 6, items.all.length
  end

  def test_it_can_delete_item_by_id
    items.delete(92929)

    assert_equal 5, items.all.length
  end
end
