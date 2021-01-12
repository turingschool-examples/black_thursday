require 'minitest/autorun'
require 'minitest/pride'
require 'mocha/minitest'
require './lib/invoice_item'
require './lib/invoice_item_repo'
require './lib/invoice_repo'
require './lib/invoice'
require './lib/sales_engine'
require './lib/merchant'
require './lib/merchant_repo'
require './lib/item'
require './lib/item_repo'

class InvoiceItemTest < MiniTest::Test
  def test_it_exists
    i = InvoiceItem.new({
                        :id         => 2345,
                        :item_id    => 263562118,
                        :invoice_id => 522,
                        :unit_price => BigDecimal("847.87"),
                        :created_at => Time.now,
                        :updated_at => Time.now
                        })

    assert_instance_of InvoiceItem, i
  end

  def test_it_has_attributes
    i = InvoiceItem.new({
                        :id         => 2345,
                        :item_id    => 263562118,
                        :invoice_id => 522,
                        :unit_price => BigDecimal("847.87"),
                        :created_at => Time.now,
                        :updated_at => Time.now
                        })

    assert_equal 2345, i.id
    assert_equal 263562118, i.item_id
    assert_equal 522, i.invoice_id
    assert_equal BigDecimal("847.87"), i.unit_price
    assert_instance_of Time, i.created_at
    assert_instance_of Time, i.updated_at
  end
end
