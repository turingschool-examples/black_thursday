# frozen_string_literal: false

require_relative 'test_helper'
require './lib/sales_engine'
require './lib/item_repository'

class ItemRepositoryTest < Minitest::Test
  def setup
    @se = SalesEngine.from_csv(items: './data/items.csv')
    @ir = @se.items
  end

  def test_it_exists
    assert_instance_of ItemRepository, @ir
  end

  def test_item_repo_holds_all_instances_of_items
    assert_equal 1_367, @ir.all.length
  end

  def test_all_returns_array_of_all_item_objects
    items = @ir.all
    assert items.all? do |item|
      item.class == Item
    end
  end

  def test_find_by_id_returns_items_with_given_id
    refute @ir.find_by_id('notarealid')
    assert_instance_of Item, @ir.find_by_id(263_395_237)
    assert_equal 263_395_237, @ir.find_by_id(263_395_237).id

    result = '510+ RealPush Icon Set'
    assert_equal result, @ir.find_by_id(263_395_237).name
  end

  def test_find_by_name_returns_item_object_with_given_name
    refute @ir.find_by_name('notarealname')
    name = '510+ RealPush Icon Set'
    assert_instance_of Item, @ir.find_by_name(name)
    assert_equal 263_395_237, @ir.find_by_name(name).id
    assert_equal name, @ir.find_by_name(name).name
  end

  def test_find_all_by_name_fragment
    assert_instance_of Array, @ir.find_all_by_name('art')
    assert_equal 105, @ir.find_all_by_name('art').length
    assert_equal [], @ir.find_all_by_name('asdgihweogdv')
  end

  def test_it_can_create_a_new_item_object
    refute @ir.find_by_id(263_567_475)
    @ir.create(name: 'test_item',
               description: 'this is a test item',
               unit_price: '1200',
               merchant_id: '456782345',
               created_at: Time.now,
               updated_at: Time.now)
    assert_equal 'test_item', @ir.find_by_id(263_567_475).name
  end

  def test_it_can_update_item_name
    @ir.create(name: 'test_item',
               description: 'this is a test item',
               unit_price: '1200',
               merchant_id: '456782345',
               created_at: Time.now,
               updated_at: Time.now)
    assert @ir.find_by_name('test_item')
    refute @ir.find_by_name('test_item_new')

    @ir.update(263_567_475, name: 'test_item_new',
                            description: 'This is a test.',
                            unit_price: BigDecimal(500.01, 5),
                            created_at: Time.now,
                            updated_at: Time.now,
                            merchant_id: 100)
    refute @ir.find_by_name('test_item')
    assert @ir.find_by_name('test_item_new')
  end

  def test_it_can_delete_a_item_object
    assert @ir.find_by_id(263_567_474)
    @ir.delete(263_567_474)
    refute @ir.find_by_id(263_567_474)
  end
end
