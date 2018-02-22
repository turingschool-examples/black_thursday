require_relative 'test_helper'
require_relative '../lib/item'
require_relative '../lib/item_repository'
require_relative '../lib/merchant'
require_relative '../lib/sales_engine'
require 'bigdecimal'
require 'pry'

# test for item class
class ItemTest < Minitest::Test
  def setup
    @data = { id: 1,
              name: 'Pencil',
              description: 'You can use it to write things',
              unit_price: 1200,
              merchant_id: 2,
              created_at: '2016-01-11 11:51:37 UTC',
              updated_at: '2016-01-11 11:51:37 UTC' }
  end

  def test_it_exists
    item = Item.new(@data, 'parent')

    assert_instance_of Item, item
  end

  def test_it_has_attributes
    item = Item.new(@data, 'parent')

    assert_equal 1, item.id
    assert_equal 'Pencil', item.name
    assert_equal 'You can use it to write things', item.description
    assert_equal 12.00, item.unit_price
  end

  def test_it_has_more_attributes
    item = Item.new(@data, 'parent')

    assert_equal 2, item.merchant_id
    assert_instance_of Time, item.created_at
    assert_instance_of Time, item.updated_at
    assert_equal 'parent', item.parent
  end

  def test_unit_price_to_dollars
    item = Item.new(@data, 'parent')

    assert_equal 12, item.unit_price_to_dollars
  end

  def test_parent_instance_of_item_repo
    parent = ItemRepository.new('./test/fixtures/items.csv', 'engine')
    item = Item.new(@data, parent)

    assert_instance_of ItemRepository, item.parent
    assert_equal 5, item.parent.all.count
  end

  def test_merchant_method_sends_to_repo
    se = SalesEngine.from_csv(items: './test/fixtures/items.csv',
                              merchants: './test/fixtures/merchants.csv')
    parent = ItemRepository.new('./test/fixtures/items.csv', se)
    item = Item.new(@data, parent)

    assert_instance_of Merchant, item.merchant
    assert_equal item.merchant.id, item.merchant_id
  end
end
