require_relative 'test_helper'
require_relative '../lib/item_repository'

class ItemRepositoryTest < Minitest::Test
  def setup
    item_csv = './test/fixtures/items_list_truncated.csv'
    parent = 'parent'
    @ir = ItemRepository.new(item_csv, parent)
  end

  def data
    {
      id: 1,
      item_id: 263_395_237,
      invoice_id: 1227,
      quantity: 5,
      unit_price: 34_873,
      created_at: '2009-02-07',
      updated_at: '2014-03-15'
    }
  end

  def test_it_exists
    assert_instance_of ItemRepository, @ir
    assert_equal 'parent', @ir.parent
  end

  def test_item_csv_parsed
    assert_equal 25, @ir.items.length
    assert_equal 263_395_237, @ir.items.first.id
  end

  def test_all_items
    assert_equal 25, @ir.all.length
    assert @ir.all[3].is_a?(Item)
    assert @ir.all[0].description.include?('googlepicasa')
  end

  def test_find_by_id
    assert_nil @ir.find_by_id(111)
    assert_equal 263_395_237, @ir.find_by_id(263_395_237).id
  end

  def test_find_by_name
    actual = @ir.find_by_name('510+ RealPush Icon Set').name

    assert_nil @ir.find_by_name('help meadsfadsf')
    assert_equal '510+ RealPush Icon Set', actual
  end

  def test_find_all_with_description
    assert_equal [], @ir.find_all_with_description('help me')
    assert_equal 1, @ir.find_all_with_description('Free standing woo').length
  end

  def test_find_all_by_price
    assert_equal [], @ir.find_all_by_price(111_245_6)
    assert_equal 7.00, @ir.find_all_by_price(7.00).first.unit_price_to_dollars
  end

  def test_find_all_by_price_in_range
    assert_equal 1, @ir.find_all_by_price_in_range(0..2).length
    assert_equal 2, @ir.find_all_by_price_in_range(13.00..14.00).length
  end

  def test_find_all_by_merchant_id
    assert_equal [], @ir.find_all_by_merchant_id(1)
    assert_equal 263_395_617, @ir.find_all_by_merchant_id(123_341_85).first.id
    assert_equal 263_396_013, @ir.find_all_by_merchant_id(123_341_85).last.id
    assert_equal 3, @ir.find_all_by_merchant_id(123_341_85).length
  end

  def test_find_all_by_invoice_items
    invoice_items = [InvoiceItem.new(data, 'InvoiceItemRepository pointer')]
    actual = @ir.find_all_by_invoice_items(invoice_items)

    assert @ir.find_all_by_invoice_items([]).empty?
    assert_instance_of Array, actual
    assert_instance_of Item, actual.first
    assert_equal 263_395_237, actual.first.id
    assert_equal 1, actual.length
  end

  def test_inspect
    assert_equal '#<ItemRepository 25 rows>', @ir.inspect
  end
end
