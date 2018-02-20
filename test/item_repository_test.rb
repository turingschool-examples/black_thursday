# frozen_string_literal: true

require_relative 'test_helper'

require 'bigdecimal'
require_relative '../lib/item_repository'
require_relative '../lib/item'

class ItemReposityTest < Minitest::Test
  def setup
    @ir = ItemRepository.new './test/fixtures/items.csv'
  end

  def test_does_create_repository
    assert_instance_of ItemRepository, @ir
  end

  def test_did_load_items
    items = @ir.all
    assert_instance_of Array, items
    items.each do |item|
      assert_instance_of Item, item
    end

    assert_equal 'Desc A', items[0].description
  end

  def test_can_find_item_by_id
    item = @ir.find_by_id 1
    assert_instance_of Item, item
    assert_equal 1, item.id
  end

  def test_can_find_item_by_name
    item = @ir.find_by_name 'Item B'
    assert_instance_of Item, item
    assert_equal 2, item.id
    assert_equal 'Item B', item.name
  end

  def test_can_find_items_by_partial_desc
    items = @ir.find_all_with_description 'C'
    assert_instance_of Array, items
    items.each do |item|
      assert_instance_of Item, item
      assert item.description.downcase.include?('c')
    end

    assert_equal [], @ir.find_all_with_description('Jack')
  end
end
