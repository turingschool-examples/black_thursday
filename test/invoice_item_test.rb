require './test/test_helper'
require './lib/invoice_item'
require 'csv'

class InvoiceItemTest < Minitest::Test
  attr_reader :invoice_item_rows, :invoice_item_1

  def setup
    fixture = CSV.open('./test/fixtures/invoice_items_fixture.csv',
                         headers:true,
                         header_converters: :symbol)
    @invoice_item_rows = fixture.to_a
    @invoice_item_1 = InvoiceItem.new(invoice_item_rows[0])
  end

  def test_has_fixnum_ids
    assert_equal 10000, invoice_item_1.id
    assert_equal 1, invoice_item_1.item_id
    assert_equal 1, invoice_item_1.invoice_id
  end

  def test_has_fixnum_quantity
    assert_equal 5, invoice_item_1.quantity
  end

  def test_has_time_objects
    assert_instance_of Time, invoice_item_1.created_at
    assert_instance_of Time, invoice_item_1.updated_at
  end

  def test_has_bigdecimal_object
    assert_instance_of BigDecimal, invoice_item_1.unit_price
  end

  def test_method_unit_price_to_dollars_returns_float
    assert 1.0, invoice_item_1.unit_price_to_dollars
  end

  def test_method_bulk_price_returns_bigdecimal
    assert_equal 109.8, invoice_item_1.bulk_price
  end
end
