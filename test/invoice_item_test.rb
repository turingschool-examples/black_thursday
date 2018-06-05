require './test_helper'
require './lib/invoice_item'
require './lib/file_loader'
require './lib/sales_engine'
require 'mocha/minitest'
require 'bigdecimal'
require 'pry'

class InvoiceItemTest < MiniTest::Test
  def setup
    se = SalesEngine.from_csv({
    :items => "./data/mock.csv",
    :merchants => "./data/mock.csv",
    :invoices => "./data/mock.csv",
    :invoice_items => "./data/invoice_items.csv",
    :transactions => "./data/mock.csv",
    :customers => "./data/mock.csv"
    })

    @iir = se.invoice_items
    @invoice_item = @iir.find_by_id(2345)
  end

  def test_invoice_item_stores_id_as_integer
    assert_equal 2345, @invoice_item.id
    assert_instance_of Fixnum, @invoice_item.id
  end

  def test_invoice_item_stores_item_id_as_integer
    assert_equal 263562118, @invoice_item.item_id
    assert_instance_of Fixnum, @invoice_item.item_id
  end

  def test_invoice_item_stores_invoice_id_as_integer
    assert_equal 522, @invoice_item.invoice_id
    assert_instance_of Fixnum, @invoice_item.invoice_id
  end

  def test_invoice_item_stores_unit_price_as_big_decimal
    assert_equal 847.87, @invoice_item.unit_price
    assert_instance_of BigDecimal, @invoice_item.unit_price
  end

  def test_invoice_item_stores_created_at_as_time_object
    assert_equal Time.parse("2012-03-27 14:54:35 UTC"), @invoice_item.created_at
    assert_instance_of Time, @invoice_item.created_at
  end

  def test_invoice_item_stores_updated_at_as_time_object
    assert_equal Time.parse("2012-03-27 14:54:35 UTC"), @invoice_item.updated_at
    assert_instance_of Time, @invoice_item.updated_at
  end

  def test_invoice_item_can_return_unit_price_in_dollars
    assert_equal 847.87, @invoice_item.unit_price_to_dollars
  end
end
