require './lib/invoice_item'
require './test/test_helper'


class InvoiceItemTest < Minitest::Test
  def test_it_exists
    invoice_item = InvoiceItem.new(1, 54321, 4, 2, "2196",
                          "2016-01-11 09:34:06 UTC",
                          "2016-01-11 09:34:06 UTC",
                          self)

    assert_instance_of InvoiceItem, invoice_item
  end

  def test_it_is_created_with_state
    invoice_item = InvoiceItem.new(1, 54321, 4, 2, "2196",
                          "2016-01-11 09:34:06 UTC",
                          "2016-01-11 09:34:06 UTC",
                          self)

    assert_equal 1, invoice_item.id
    assert_equal 54321, invoice_item.item_id
    assert_equal 4, invoice_item.invoice_id
    assert_equal 2, invoice_item.quantity
    assert_equal 21.96, invoice_item.unit_price
    assert_equal Time.parse("2016-01-11 09:34:06 UTC"), invoice_item.created_at
    assert_equal Time.parse("2016-01-11 09:34:06 UTC"), invoice_item.updated_at
  end

  def test_it_can_convert_price
    invoice_item = InvoiceItem.new(1, 54321, 4, 2, "2196",
                          "2016-01-11 09:34:06 UTC",
                          "2016-01-11 09:34:06 UTC",
                          self)
    invoice_item_2 = InvoiceItem.new(2, 12345, 3, 2, "1400",
                          "2016-01-11 09:34:06 UTC",
                          "2016-01-11 09:34:06 UTC",
                          self)

    assert_equal 21.96, invoice_item.unit_price_to_dollars
    assert_equal 14.00, invoice_item_2.unit_price_to_dollars
  end

end
