require_relative './test_helper'
require_relative '../lib/invoice_item'
require 'bigdecimal'

class InvoiceItemTest < Minitest::Test

    def test_it_exists
      i = InvoiceItem.new({
        :id => 6,
        :item_id => 7,
        :invoice_id => 8,
        :quantity => 1,
        :unit_price => BigDecimal.new(10.99, 4),
        :created_at => Time.now,
        :updated_at => Time.now
      })
      assert_instance_of InvoiceItem, i
    end

    def test_it_has_attributes
      i = InvoiceItem.new({
        :id => 6,
        :item_id => 7,
        :invoice_id => 8,
        :quantity => 1,
        :unit_price => BigDecimal.new(10.99, 4),
        :created_at  => Time.parse("2016-01-11 09:34:06 UTC",),
        :updated_at  => Time.parse("2007-06-04 21:35:10 UTC"),
      })
      assert_equal 6, i.id
      assert_equal 7, i.item_id
      assert_equal 8, i.invoice_id
      assert_equal 1, i.quantity
      assert_equal 10.99, i.unit_price
    end

    def test_it_converts_price_to_float
      i = InvoiceItem.new({
        :id => 6,
        :item_id => 7,
        :invoice_id => 8,
        :quantity => 1,
        :unit_price => BigDecimal.new(10.99, 4),
        :created_at => Time.now,
        :updated_at => Time.now
      })
      assert_equal 10.99, i.unit_price_to_dollars
    end

    def test_it_returns_created_at
      i = InvoiceItem.new({
        :id => 6,
        :item_id => 7,
        :invoice_id => 8,
        :quantity => 1,
        :unit_price => BigDecimal.new(10.99, 4),
        :created_at => Time.now,
        :updated_at => Time.now
      })
      assert_instance_of Time, i.created_at
    end

    def test_it_returns_updated_at
      i = InvoiceItem.new({
        :id => 6,
        :item_id => 7,
        :invoice_id => 8,
        :quantity => 1,
        :unit_price => BigDecimal.new(10.99, 4),
        :created_at => Time.now,
        :updated_at => Time.now
      })
      assert_instance_of Time, i.updated_at
    end

end
