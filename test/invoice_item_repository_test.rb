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
    invoice_item_nil = inv_ir.find_by_id(8675309)
    assert_instance_of InvoiceItem, invoice_item
    assert_equal 10000,          invoice_item.id
    assert_equal nil,        invoice_item_nil
  end

  def test_method_find_all_by_item_id_returns_array_of_items
    invoice_items = inv_ir.find_all_by_item_id(1)
    invoice_items_multiple = inv_ir.find_all_by_item_id(2)
    invoice_items_empty = inv_ir.find_all_by_item_id(9000..9001)
    assert_equal inv_ir.invoice_items[0], invoice_items[0]
    assert_equal true, invoice_items_multiple.length > 1
    assert_equal [], invoice_items_empty
  end

  def test_method_find_all_by_invoice_id_returns_array_of_items
    invoice_items = inv_ir.find_all_by_invoice_id(1)
    invoice_items_multiple = inv_ir.find_all_by_invoice_id(2)
    invoice_items_empty = inv_ir.find_all_by_invoice_id(9000..9001)
    assert_equal inv_ir.invoice_items[0], invoice_items[0]
    assert_equal true, invoice_items_multiple.length > 1
    assert_equal [], invoice_items_empty
  end
end
