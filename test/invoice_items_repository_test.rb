require './test/test_helper'
require './lib/invoice_item_repository'
require 'csv'

class InvoiceItemRepositoryTest < Minitest::Test
  attr_reader :inv_ir

  def setup
    fixture = CSV.open('./test/fixtures/invoice_items_fixture.csv',
                          headers: true,
                          header_converters: :symbol)
    csv_rows = fixture.to_a
    @inv_ir = InvoiceItemRepository.new(csv_rows)
  end

  def test_method_invoice_items_returns_array_of_invoice_items
    assert_instance_of Array, inv_ir.invoice_items
    assert_equal true, inv_ir.invoice_items.all? { |thing| thing.class == InvoiceItem }
  end

  def test_method_all_returns_array_of_items
    assert_equal inv_ir.invoice_items, inv_ir.all
  end

  def test_method_find_by_id_returns_nil_or_item
    invoice_item =     inv_ir.find_by_id(10000)
    invoice_item_nil = inv_ir.find_by_id('googleypuff')
    assert_instance_of InvoiceItem, invoice_item
    assert_equal 10000,          invoice_item.id
    assert_equal nil,        invoice_item_nil
  end
#
#   def test_method_find_all_by_price_returns_array_of_items
#     items =           inv_ir.find_all_by_price(1.00)
#     items_empty =     inv_ir.find_all_by_price(12345679.10)
#     items_multiple =  inv_ir.find_all_by_price(1.99)
#     assert_equal inv_ir.items[0].unit_price, items[0].unit_price
#     assert_equal [],                     items_empty
#     assert_equal true,                   items_multiple.length > 1
#   end
#
#   def test_method_find_all_by_price_in_range_returns_array_of_items
#     items_multiple = inv_ir.find_all_by_price_in_range(1..2)
#     items_empty =    inv_ir.find_all_by_price_in_range(9000..9001)
#     assert_equal true, items_multiple.length > 1
#     assert_equal [],   items_empty
#   end
# #
#   def test_method_find_all_by_merchant_id_returns_array_of_items
#     items = inv_ir.find_all_by_merchant_id(1000)
#     items_multiple = inv_ir.find_all_by_merchant_id(1001)
#     items_empty = inv_ir.find_all_by_merchant_id(9000..9001)
#     assert_equal inv_ir.items[0], items[0]
#     assert_equal true, items_multiple.length > 1
#     assert_equal [], items_empty
#   end
#
#   def test_method_find_merchant_by_id_returns_merchant
#     mock_se = Minitest::Mock.new
#     inv_ir = ItemRepository.new([], mock_se)
#     mock_se.expect(:find_merchant_by_id, nil, [1000])
#     inv_ir.find_merchant_by_id(1000)
#     assert mock_se.verify
#   end
end
