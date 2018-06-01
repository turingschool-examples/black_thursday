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
    :items => "./data/item_sample.csv",
    :merchants => "./data/merchant_sample.csv",
    :invoices => "./data/invoices.csv",
    :invoice_items => "./data/invoice_items.csv"
    })

    @iir = se.invoices
  end

  def test_invoice_stores_id_as_integer
    assert_equal 1, @invoice_item_1.id
    assert_instance_of Fixnum, @invoice_item_1.id
  end

  def test_invoice_stores_customer_id_as_integer
    assert_equal 2, @invoice_item_1.item_id
    assert_instance_of Fixnum, @invoice_item_1.item_id
  end

  def test_invoice_stores_merchant_id_as_integer
    skip
    assert_equal 12335955, @invoice_3.merchant_id
    assert_instance_of Fixnum, @invoice_3.merchant_id
  end

  def test_invoice_stores_status_as_symbol
    skip
    assert_equal :shipped, @invoice_3.status
    assert_instance_of Symbol, @invoice_3.status
  end

  def test_invoice_stores_created_at_as_time_object
    skip
    assert_equal Time.parse('2004-02-14'), @invoice_3.created_at
    assert_instance_of Time, @invoice_3.created_at
  end

  def test_invoice_stores_updated_at_as_time_object
    skip
    assert_equal Time.parse('2010-03-26'), @invoice_3.updated_at
    assert_instance_of Time, @invoice_3.updated_at
  end

  def test_invoice_can_return_created_at_day_of_the_week
    skip
    attributes = {:id => 13,
                  :customer_id => 3,
                  :merchant_id => 12335955,
                  :status => :shipped,
                  :created_at => Time.parse('2004-02-14'),
                  :updated_at => Time.parse('2010-03-26')}

    invoice_4 = Invoice.new(attributes)
    assert_equal "Saturday", invoice_4.day_of_week
  end
end
