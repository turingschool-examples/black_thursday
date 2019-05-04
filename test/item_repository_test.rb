# frozen_string_literal: true

require 'time'
require 'timecop'
require_relative 'test_helper'
require './lib/item_repository'
require './lib/sales_engine'
require 'pry'

# This is an ItemRepository Class
class ItemRepositoryTest < Minitest::Test
  def setup
    @se = SalesEngine.from_csv( { :items     => './test/fixtures/items_truncated.csv',
                                  :merchants => './test/fixtures/merchants_truncated.csv',
                                } )
    @ir = @se.items
  end

  def test_it_exists
    assert_instance_of ItemRepository, @ir
  end

  def test_it_has_items
    assert_equal 5, @ir.all.count
    assert_instance_of Array, @ir.all
    assert(@ir.all.all?) { |item| item.is_a?(Item) }
  end

  def test_find_items_by_id
    assert_nil @ir.find_by_id(777)
    assert_instance_of Item, @ir.find_by_id(1)
  end

  def test_find_items_by_name
    name = 'Disney scrabble frames'
    name_case_insensitive = 'disney SCRABBLE FraMeS'

    assert_nil @ir.find_by_name('beebop')
    assert_instance_of Item, @ir.find_by_name(name)
    assert_instance_of Item, @ir.find_by_name(name_case_insensitive)
  end

  def test_find_all_with_description
    description = 'Almost every social icon on the planet earth'

    assert_equal [], @ir.find_all_with_description('beebop')
    assert_instance_of Item, @ir.find_all_with_description(description)[0]
    assert_equal 5, @ir.find_all_with_description('a').count
  end

  def test_find_all_by_price
    assert_equal [], @ir.find_all_by_price(777)
    assert_instance_of Item, @ir.find_all_by_price(13.5)[0]
  end

  def test_find_all_by_price_in_range
    assert_equal [], @ir.find_all_by_price_in_range((0..1))
    assert_instance_of Item, @ir.find_all_by_price_in_range((1..15))[0]
    assert_equal 5, @ir.find_all_by_price_in_range((1..100_00)).count
  end

  def test_find_all_by_merchant_id
    assert_equal [], @ir.find_all_by_merchant_id(7_77)
    assert_instance_of Item, @ir.find_all_by_merchant_id(2)[0]
  end

  def test_find_highest_id
    assert_equal 263_396_209, @ir.find_highest_id
  end

  def test_create_new_id
    assert_equal 263_396_210, @ir.create_new_id
  end

  def test_create_item
    assert_equal 263_396_210, @ir.create_new_id

    @ir.create({
                  :name        => 'Pencil',
                  :description => 'You can use it to write things',
                  :unit_price  => BigDecimal(10.99, 4),
                })

    assert_equal 263_396_210, @ir.items.last.id
    assert_equal 'Pencil', @ir.items.last.name
    assert_equal 'You can use it to write things', @ir.items.last.description
  end

  def test_update_item
    attributes = ({
                    :name        => 'Pencil',
                    :description => 'You can use it to write things',
                    :unit_price  => BigDecimal(10.99, 4),
                    :created_at  => '1995-03-19 10:02:43 UTC',
                    :updated_at  => '1995-03-19 10:02:43 UTC',
                  })

    to_update = @ir.find_by_id(263_396_209)

    assert_equal 'Vogue Paris Original Givenchy 2307', to_update.name
    assert_equal 29.99, to_update.unit_price

    @ir.update(263_396_209, attributes)

    assert_equal 'Pencil', to_update.name
    assert_equal 10.99, to_update.unit_price
  end

  def test_delete_item
    assert_equal 5, @ir.items.count

    @ir.delete(1)

    assert_nil @ir.find_by_id(1)
    assert_equal 4, @ir.items.count
  end
end
