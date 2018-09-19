require_relative 'test_helper'

require 'time'

require_relative '../lib/invoice_item'

class InvoiceItemTest < Minitest::Test

  def setup
    hash = {
              :id             => "6",
              :item_id        => "7",
              :invoice_id     => "8",
              :quantity       => "1",
              :unit_price     => "1200",
              :created_at     => "2016-01-11 09:34:06 UTC",
              :updated_at     => "2007-06-04 21:35:10 UTC"
    }
    @invoice_item = InvoiceItem.new(hash)
    @big_decimal = BigDecimal(12.00, 4)
  end


  def test_it_exists
   assert_instance_of InvoiceItem, @invoice_item
  end

  def test_it_has_attributes
    assert_equal 6, @invoice_item.id
    assert_equal 7, @invoice_item.item_id
    assert_equal 8, @invoice_item.invoice_id
    assert_equal 1, @invoice_item.quantity
    assert_equal @big_decimal, @invoice_item.unit_price
    assert_instance_of Time, @invoice_item.created_at
    assert_equal "2016-01-11 09:34:06 UTC", @invoice_item.created_at.to_s
    assert_instance_of Time, @invoice_item.updated_at
    assert_equal "2007-06-04 21:35:10 UTC", @invoice_item.updated_at.to_s
  end

  def test_it_calculates_unit_price_in_dollars
    price = @invoice_item.unit_price_to_dollars
    assert_instance_of Float, price
    assert_equal 12.00, price
  end

  def test_it_can_make_updates
    now = Time.now
    hash = {id: "NOPE", item_id: "NOPE", invoice_id: "NOPE", created_at: "NOPE",
            quantity: 100, unit_price: 1000,
            updated_at: now }
    @invoice_item.make_update(hash)
    # --- denied ---
    refute_equal "NOPE", @invoice_item.id
    refute_equal "NOPE", @invoice_item.item_id
    refute_equal "NOPE", @invoice_item.invoice_id
    refute_equal "NOPE", @invoice_item.created_at
    # --- allowed ---
    assert_equal 100, @invoice_item.quantity
    assert_equal 10.0,  @invoice_item.unit_price
    assert_equal now.to_s, @invoice_item.updated_at.to_s
  end



end
