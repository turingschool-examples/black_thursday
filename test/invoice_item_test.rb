require_relative './test_helper'
require_relative '../lib/invoice_item'

class InvoiceItemTest < Minitest::Test
  def test_initializing_with_a_hash
    invoice_item = InvoiceItem.new({:id => 35})

    assert_equal 35, invoice_item.id
  end

  def test_it_has_all_the_things
    invoice_item = InvoiceItem.new({:id => 400, :item_id => 257, :invoice_id => 333, :quantity => 10,
      :unit_price => 10000, :created_at => Time.now, :updated_at => Time.now})

      assert_equal 400, invoice_item.id
      assert_equal 257, invoice_item.item_id
      assert_equal 333, invoice_item.invoice_id
      assert_equal 10, invoice_item.quantity
      assert_equal 100.00, invoice_item.unit_price
      assert_respond_to invoice_item, :created_at
      assert_respond_to invoice_item, :updated_at
  end

  def test_it_accepts_partial_data
    invoice_item = InvoiceItem.new({:id => 1, :quantity => 9})
    assert_equal 1, invoice_item.id
    assert_equal 9, invoice_item.quantity
    assert_equal 0, invoice_item.invoice_id
  end

  def test_unit_price_is_big_decimal
    invoice_item_details = {
      :id => 8675309,
      :invoice_id => 123,
      :unit_price => 25000,
      :created_at => "1994-05-07 23:38:43 UTC",
      :updated_at => "2016-01-11 11:30:35 UTC"
    }
    invoice_item = InvoiceItem.new(invoice_item_details)
    assert_equal BigDecimal, invoice_item.unit_price.class
    assert_equal 250.00, invoice_item.unit_price
  end

  def test_unit_price_to_dollars
    invoice_item_details = {
      :id => 125,
      :unit_price => 25000,
      :merchant_id => 12345,
      :created_at => "1994-05-07 23:38:43 UTC",
      :updated_at => "2016-01-11 11:30:35 UTC"
    }
    invoice_item = InvoiceItem.new(invoice_item_details)
    assert_equal 250.0, invoice_item.unit_price_to_dollars
  end

end
