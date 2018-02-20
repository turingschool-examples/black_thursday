require_relative 'test_helper'
require_relative '../lib/item'
require 'time'

class ItemTest < Minitest::Test
  def setup
    @data = {
      id: 263_395_721,
      name: 'Disney scrabble frames',
      description: 'Disney glitter frames...',
      unit_price: 1350,
      merchant_id: 123_341_85,
      created_at: '2016-01-11 11:51:37 UTC',
      updated_at: '2008-04-02 13:48:57 UTC'
    }
    @item = Item.new(@data, 'ItemRepository pointer')
  end

  def test_it_exists
    assert_instance_of Item, @item
  end

  def test_it_initializes_with_information
    assert_equal 263_395_721, @item.id
    assert_equal 'Disney scrabble frames', @item.name
    assert_equal 'Disney glitter frames...', @item.description
    assert_equal 0.135e2, @item.unit_price
    assert_equal Time.utc(2016, 01, 11, 11, 51, 37), @item.created_at
    assert_equal Time.utc(2008, 04, 02, 13, 48, 57), @item.updated_at
    assert_equal 'ItemRepository pointer', @item.parent
  end

  def test_item_attributes_have_correct_class
    assert_instance_of BigDecimal, @item.unit_price
    assert_instance_of Time, @item.created_at
    assert_instance_of Time, @item.updated_at
  end

  def test_unit_price_to_dollars
    assert_equal 13.50, @item.unit_price_to_dollars
  end

  def test_finding_merchant_associated_with_item
    information = { items: './test/fixtures/items_list_truncated.csv',
                    merchants: './test/fixtures/merchants_list_truncated.csv',
                    invoices: './test/fixtures/invoices_list_truncated.csv' }
    sales_engine = SalesEngine.from_csv(information)
    item = sales_engine.items.find_by_id(263_395_237)

    assert_instance_of Merchant, item.merchant
    assert_equal 12_334_141, item.merchant.id
  end
end
