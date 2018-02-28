require 'bigdecimal'
require_relative 'test_helper'
require_relative '../lib/item'
require_relative '../lib/sales_engine'
require_relative './master_hash'

class ItemTest < Minitest::Test
  def setup
    test_engine = TestEngine.new.god_hash
    @sales_engine = SalesEngine.new(test_engine)
    @item = Item.new({
      name: 'Pencil',
      description: 'You can use it to write things',
      unit_price: BigDecimal.new(1099, 4),
      created_at: '2018-02-21 19:23:23 UTC',
      updated_at: '2018-02-21 19:23:23 UTC'
      }, @sales_engine.items)
  end

  def test_it_exists
    item = @item

    assert_instance_of Item, item
  end

  def test_it_has_attributes
    item = @item

    assert_equal 'Pencil', item.name
    assert_equal 'You can use it to write things', item.description
    assert_equal 10.99, item.unit_price
    assert_instance_of Time, item.created_at
    assert_instance_of Time, item.updated_at
  end

  def test_it_can_have_different_attributes
    item = Item.new({
      name:         'Apple',
      description:  'A fruit that grows on trees',
      unit_price:    BigDecimal.new(3_600, 4),
      created_at:   '2017-01-12 19:23:23 UTC',
      updated_at:   '1917-01-12 19:23:23 UTC'
      }, @sales_engine.items)

    assert_equal 'Apple', item.name
    assert_equal 'A fruit that grows on trees', item.description
    assert_equal 36, item.unit_price
    assert_instance_of Time, item.created_at
    assert_instance_of Time, item.updated_at
  end

  def test_unit_price_converts_to_dollar
    item = @item

    assert_equal 10.99, item.unit_price_to_dollars
  end

  def test_item_merchant_returns_merchant
    item = @sales_engine.items.find_by_id(263_395_237)
    result = item.merchant

    assert_instance_of Merchant, result
  end
end
