require_relative 'test_helper'
require_relative '../lib/invoice_item'

class InvoiceItemTest < Minitest::Test
  def setup
    @iir = mock('invoiceitemrepository')
    @ii = InvoiceItem.new({
      id: 6,
      item_id: 7,
      invoice_id: 8,
      quantity: 1,
      unit_price: 1099,
      created_at: Time.now.inspect,
      updated_at: Time.now.inspect
      }, @iir)
  end

  def test_it_has_an_id
    assert_equal 6, @ii.id
  end

  def test_it_has_an_item_id
    assert_equal 7, @ii.item_id
  end

  def test_it_has_an_invoice_id
    assert_equal 8, @ii.invoice_id
  end

  def test_it_has_an_quantity
    assert_equal 1, @ii.quantity
  end

  def test_it_has_a_unit_price
    assert_equal 10.99, @ii.unit_price
  end

  def test_it_has_a_time_created_at
    assert_equal Time.now.inspect, @ii.created_at.inspect
  end

  def test_it_has_a_time_updated_at
    assert_equal Time.now.inspect, @ii.updated_at.inspect
  end

  def test_unit_price_to_dollars_returns_unit_price_as_a_float
    assert_equal 10.99, @ii.unit_price_to_dollars
  end
end
