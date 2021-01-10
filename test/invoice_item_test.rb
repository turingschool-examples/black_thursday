require 'time'
require 'csv'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/invoice_item'

class InvoiceItemTest < Minitest::Test
  def test_it_has_readable_attributes
    invoice_item = InvoiceItem.new({
                                     :id          => '10',
                                     :item_id     => '263523644',
                                     :invoice_id  => '2',
                                     :quantity    => '4',
                                     :unit_price  => BigDecimal(10.99,4),
                                     :created_at  => '2012-03-27 14:54:09 UTC',
                                     :updated_at  => '2012-03-27 14:54:09 UTC'
                                    })

    assert_instance_of InvoiceItem, invoice_item
    assert_equal 10, invoice_item.id
    assert_equal 263523644, invoice_item.item_id
    assert_equal 2, invoice_item.invoice_id
    assert_equal 4, invoice_item.quantity
    assert_equal (0.10), invoice_item.unit_price
    assert_equal Time.parse('2012-03-27 14:54:09 UTC'), invoice_item.created_at
    assert_equal Time.parse('2012-03-27 14:54:09 UTC'), invoice_item.updated_at
  end

  def test_unit_price_to_dollars
    invoice_item = InvoiceItem.new({
                                     :id          => '10',
                                     :item_id     => '263523644',
                                     :invoice_id  => '2',
                                     :quantity    => '4',
                                     :unit_price  => BigDecimal(10.99,4),
                                     :created_at  => '2012-03-27 14:54:09 UTC',
                                     :updated_at  => '2012-03-27 14:54:09 UTC'
                                    })

    assert_equal (0.10), invoice_item.unit_price_to_dollars
  end
end
