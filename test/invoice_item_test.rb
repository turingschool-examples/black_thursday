require 'simplecov'
SimpleCov.start
require 'minitest/pride'
require 'minitest/autorun'
require_relative '../lib/invoice_item'

class InvoiceItemTest < Minitest::Test

  def setup
    @invoice_item = InvoiceItem.new({id: 1,
                                     item_id: 1,
                                     invoice_id: 1,
                                     quantity: 1,
                                     unit_price: 100,
                                     created_at: "2012-01-01",
                                     updated_at: "2012-01-01"})
  end

  def test_it_exists
    assert_instance_of InvoiceItem, @invoice_item
  end

  def test_it_has_attributes
    assert_equal 1, @invoice_item.id
    assert_equal 1, @invoice_item.invoice_id
  end

  def test_it_can_convert_unit_price_to_dollars
    expected = 1.0
    result = @invoice_item.unit_price_to_dollars
    assert_equal expected, result
  end


end
