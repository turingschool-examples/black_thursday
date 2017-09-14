require_relative 'test_helper'
require './lib/sales_engine'

class ItemsTest < Minitest::Test

  def setup
    item_file_path = './test/fixtures/items_truncated.csv'
    merchant_file_path = './test/fixtures/merchants_truncated.csv'
    engine = SalesEngine.new(item_file_path, merchant_file_path)
    @item_repo = engine.items
  end

  def test_it_exists
    items = @item_repo.items
    item = items[0]

    assert_instance_of Item, item
  end

  def test_it_can_retrieve_item_attributes
    items = @item_repo.items
    item = items[0]

    assert_equal 263395617, item.id
    assert_equal 'Glitter scrabble frames', item.name
    assert item.description.include?('colour')
    assert_equal BigDecimal.new(13.00, 4), item.unit_price
    assert_instance_of Time, item.created_at
    assert_instance_of Time, item.updated_at
  end

  def test_it_can_format_item_price_as_big_decimal
    items = @item_repo.items
    item = items[0]

    assert_equal 0.43e2, item.format_unit_price(4300)
    assert_equal 43, item.format_unit_price(4300)
  end

  def test_merchant_returns_merchant_object_with_matching_id
    item = @item_repo.find_by_id(263395721)

    assert_instance_of Merchant, item.merchant
    assert_equal 'Madewithgitterxx', item.merchant.name
  end

end
