require_relative 'test_helper'
require_relative '../lib/invoice_item'

class InvoiceItemTest < Minitest::Test
    attr_reader :invoice_item

    def setup
      @invoice_item = InvoiceItem.new({
        :id => 6,
        :item_id => 7,
        :invoice_id => 8,
        :quantity => 1,
        :unit_price => BigDecimal.new(1099, 4),
        :created_at => Time.now.to_s,
        :updated_at => Time.now.to_s
      })
    end

    def test_it_creates_invoice_item_instance
      assert_equal InvoiceItem, invoice_item.class
    end

    def test_it_returns_id
      assert_equal 6, invoice_item.id
    end

    def test_it_returns_item_id
      assert_equal 7, invoice_item.item_id
    end

    def test_it_returns_invoice_id
      assert_equal 8, invoice_item.invoice_id
    end

    def test_it_returns_quantity
      assert_equal 1, invoice_item.quantity
    end

    def test_it_can_return_unit_price
      assert_equal 10.99, invoice_item.unit_price
    end

    def test_it_can_return_unit_price_in_dollars
      assert_equal 10.99, invoice_item.unit_price_in_dollars
    end

    def test_it_returns_current_time
      time = invoice_item.created_at
      current_time = Time.new
      assert_equal Time, time.class
      assert_equal current_time.year, time.year
    end

    def test_it_returns_updated_time
      time = invoice_item.updated_at
      current_time = Time.new
      assert_equal Time, time.class
      assert_equal current_time.year, time.year
    end
end
