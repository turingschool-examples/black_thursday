require './test_helper'
require './lib/invoice'
require './lib/file_loader'
require './lib/sales_engine'
require 'mocha/minitest'
require 'bigdecimal'

class InvoiceTest < MiniTest::Test
  def setup
    @invoice_1 = stub(:id => 1,
                      :customer_id => 1,
                      :merchant_id => 12335938,
                      :status => :pending,
                      :created_at => Time.parse('2009-02-07'),
                      :updated_at => Time.parse('2014-03-15'))
    @invoice_2 = stub(:id => 9,
                      :customer_id => 2,
                      :merchant_id => 12336965,
                      :status => :shipped,
                      :created_at => Time.parse('2003-03-07'),
                      :updated_at => Time.parse('2008-10-09'))
    @invoice_3 = stub(:id => 13,
                      :customer_id => 3,
                      :merchant_id => 12335955,
                      :status => :shipped,
                      :created_at => Time.parse('2004-02-14'),
                      :updated_at => Time.parse('2010-03-26'))

  end

  def test_invoice_stores_id_as_integer
    assert_equal 1, @invoice_1.id
    assert_instance_of Fixnum, @invoice_1.id
  end

  def test_invoice_stores_customer_id_as_integer
    assert_equal 2, @invoice_2.customer_id
    assert_instance_of Fixnum, @invoice_2.customer_id
  end

  def test_invoice_stores_merchant_id_as_integer
    assert_equal 12335955, @invoice_3.merchant_id
    assert_instance_of Fixnum, @invoice_3.merchant_id
  end

  def test_invoice_stores_status_as_symbol
    assert_equal :shipped, @invoice_3.status
    assert_instance_of Symbol, @invoice_3.status
  end

  def test_invoice_stores_created_at_as_time_object
    assert_equal Time.parse('2004-02-14'), @invoice_3.created_at
    assert_instance_of Time, @invoice_3.created_at
  end

  def test_invoice_stores_updated_at_as_time_object
    assert_equal Time.parse('2010-03-26'), @invoice_3.updated_at
    assert_instance_of Time, @invoice_3.updated_at
  end

  def test_invoice_can_return_created_at_day_of_the_week
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
