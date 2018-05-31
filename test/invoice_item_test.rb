require_relative 'test_helper'
require_relative 'test_helper'
require_relative '../lib/sales_engine'
require_relative '../lib/invoice_item'
require 'time'
require 'minitest/autorun'
require 'minitest/pride'
class InvoiceItemTest < Minitest::Test
  def setup
    @engine = SalesEngine.from_csv({
      items: './data/items.csv',
      merchants: './data/merchants.csv',
      customers: './data/customers.csv',
      invoices: './data/invoices.csv',
      invoice_items: './data/invoice_items.csv',
      transactions: './data/transactions.csv'
    })
    @invoice_item = @engine.invoice_items.find_by_id(2345)
  end

  def test_it_exists
    assert_instance_of InvoiceItem, @engine.invoice_items.invoice_items.first
  end

  def test_id_returns_the_invoice_item_id
    assert_equal 2345, @invoice_item.id
  end

  def test_item_id_returns_the_item_id
    assert_equal 263562118, @invoice_item.item_id
  end

  def test_invoice_id_returns_the_invoice_id
    assert_equal 522, @invoice_item.invoice_id
  end

  def test_unit_price_returns_the_unit_price
    assert_equal 847.87, @invoice_item.unit_price
  end

  def test_created_at_returns_the_correct_time
    assert_equal Time.parse('2012-03-27 14:54:35 UTC'), @invoice_item.created_at
  end

  def test_updated_at_returns_the_correct_time
    assert_equal Time.parse('2012-03-27 14:54:35 UTC'), @invoice_item.updated_at
  end
end
