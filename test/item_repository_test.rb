# frozen_string_literal: true

require_relative 'test_helper'

require 'bigdecimal'
require_relative '../lib/item_repository'
require_relative '../lib/merchant_repository'
require_relative '../lib/sales_engine'
require_relative '../lib/item'
require_relative 'mocks/test_engine'

class ItemReposityTest < Minitest::Test
  def setup
    @ir = ItemRepository.new './test/fixtures/items.csv', MOCK_SALES_ENGINE
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
    assert_equal 8, items.length
    items.each do |item|
      assert_instance_of Item, item
      assert item.description.downcase.include?('c')
    end

    assert_equal [], @ir.find_all_with_description('Jack')
  end

  def test_can_find_items_by_price
    items = @ir.find_all_by_price BigDecimal.new(2000 / 100.0, 4)
    assert_instance_of Array, items
    assert_equal 5, items.length
    items.each do |item|
      assert_instance_of Item, item
      assert_equal BigDecimal.new(2000 / 100.0, 4), item.unit_price
    end

    assert_equal [], @ir.find_all_by_price(BigDecimal.new(8000 / 100.0, 4))
  end

  def test_can_find_all_in_price_range
    items = @ir.find_all_by_price_in_range(10.00..30.00)
    assert_instance_of Array, items
    assert_equal 7, items.length
    items.each do |item|
      assert_instance_of Item, item
      assert_equal true, (10..30).cover?(item.unit_price.to_f)
    end

    assert_equal [], @ir.find_all_by_price_in_range(1_000..100_000)
  end

  def test_can_find_items_by_merchant_id
    items = @ir.find_all_by_merchant_id 400
    assert_instance_of Array, items
    assert_equal 1, items.length
    items.each do |item|
      assert_instance_of Item, item
      assert_equal 'Item D', item.name
    end

    assert_equal [], @ir.find_all_by_merchant_id(8000)
  end

  def test_overrides_inspect
    assert_equal '#<ItemRepository 8 rows>', @ir.inspect
  end

  def test_can_request_merchant_repository
    assert_instance_of SalesEngine, @ir.sales_engine
    assert_instance_of MerchantRepository, @ir.sales_engine.merchants
  end
end
