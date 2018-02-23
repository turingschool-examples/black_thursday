require './test/test_helper'
require './lib/invoice_item'

class InvoiceItemTest < Minitest::Test
  def setup
    @invoice = InvoiceItem.new(id: 6,
                           item_id: 7,
                           invoice_id: 8,
                           quantity: 9,
                           unit_price: 34567,
                           created_at: '1969-07-20 20:17:40  0600',
                           updated_at: '1979-07-20 20:17:40  0600'
                          )
  end

  def test_it_exists
    assert_instance_of InvoiceItem, @invoice
  end

  def test_it_returns_integer_id
    assert_instance_of Integer, @invoice.id
    assert_equal 6, @invoice.id
  end

  def test_it_returns_item_id
    assert_instance_of Integer, @invoice.item_id
    assert_equal 7, @invoice.item_id
  end

  def test_it_returns_invoice_id
    assert_instance_of Integer, @invoice.invoice_id
    assert_equal 8, @invoice.invoice_id
  end

  def test_it_returns_quantity
    assert_instance_of Integer, @invoice.quantity
    assert_equal 9, @invoice.quantity
  end

  def test_it_returns_unit_price
    assert_instance_of Integer, @invoice.unit_price
    assert_equal 34567, @invoice.unit_price
  end

  def test_it_returns_a_time_when_created
    assert_instance_of String, @invoice.created_at
    assert_equal '1969-07-20 20:17:40  0600', @invoice.created_at
  end

  def test_it_returns_a_time_when_updated
    assert_instance_of String, @invoice.created_at
    assert_equal '1979-07-20 20:17:40  0600', @invoice.updated_at
  end

  def test_it_coverts_unit_price_to_dollars
    assert_instance_of Float, @invoice.unit_price_to_dollars
    assert_equal 345.67, @invoice.unit_price_to_dollars
  end
end
