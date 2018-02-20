require_relative 'test_helper'
require_relative '../lib/item'
require_relative '../lib/item_repository'
require_relative '../lib/merchant'
require_relative '../lib/sales_engine'
require 'bigdecimal'
require 'pry'

class ItemTest < Minitest::Test
  def test_it_exits
    data = { id: 1,
             name: 'Pencil',
             description: 'You can use it to write things',
             unit_price: 1200,
             merchant_id: 2,
             created_at: Time.now,
             updated_at: Time.now }
    item = Item.new(data, 'parent')

    assert_instance_of Item, item
  end

  def test_it_has_attributes
    data = { id: 1,
             name: 'Pencil',
             description: 'You can use it to write things',
             unit_price: 1200,
             merchant_id: 2,
             created_at: Time.now,
             updated_at: Time.now }
    item = Item.new(data, 'parent')

    assert_equal 1, item.id
    assert_equal 'Pencil', item.name
    assert_equal 'You can use it to write things', item.description
    assert_equal 1200, item.unit_price
    assert_equal 2, item.merchant_id
    assert_instance_of Time, item.created_at
    assert_instance_of Time, item.updated_at
    assert_equal 'parent', item.parent
  end

  def test_unit_price_to_dollars
    data = { id: 1,
             name: 'Pencil',
             description: 'You can use it to write things',
             unit_price: 1200,
             merchant_id: 2,
             created_at: Time.now,
             updated_at: Time.now }
    item = Item.new(data, 'parent')

    assert_equal 12, item.unit_price_to_dollars
  end

  def test_parent_instance_of_item_repo
    data = { id: 1,
             name: 'Pencil',
             description: 'You can use it to write things',
             unit_price: 1200,
             merchant_id: 2,
             created_at: Time.now,
             updated_at: Time.now }
    parent = ItemRepository.new('./test/fixtures/items.csv', 'engine')
    item = Item.new(data, parent)

    assert_instance_of ItemRepository, item.parent
    assert_equal 5, item.parent.all.count
  end

  def test_merchant_method_sends_to_repo
    data = { id: 1,
             name: 'Pencil',
             description: 'You can use it to write things',
             unit_price: 1200,
             merchant_id: 2,
             created_at: Time.now,
             updated_at: Time.now }
    se = SalesEngine.from_csv(items: './test/fixtures/items.csv', merchants: './test/fixtures/merchants.csv')
    parent = ItemRepository.new('./test/fixtures/items.csv', se)
    item = Item.new(data, parent)

    assert_instance_of Merchant, item.merchant
    assert_equal item.merchant.id, item.merchant_id
  end
end
