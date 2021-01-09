
require_relative ‘test_helper’
require ‘./invoice’

class InvoiceTest < MiniTest::Test
  def setup
    merchant_path = “./data/merchants.csv”
    arguments = merchant_path
    #parent = mock(“parent”)
    @engine = SalesEngine.from_csv(arguments)
    @invoice = @engine.invoices.find_by_id(3452)
  end

  def test_it_exists
   assert_instance_of Invoice, @engine.invoices.all.first.class
 end

 def test_id_returns_invoice_id
   assert_equal Fixnum, @invoice.id.class
 end

 def test_customer_id_returns_the_invoice_customer_id
   assert_equal 679, @invoice.customer_id
   assert_equal Fixnum, @invoice.customer_id.class
 end

 def test_merchant_id_returns_the_invoice_merchant_id
     assert_equal 12335690, @invoice.merchant_id
     assert_equal Fixnum, @invoice.merchant_id.class
   end
   def test_status_returns_the_invoice_status
     assert_equal :pending, @invoice.status
     assert_equal Symbol, @invoice.status.class
   end
   def test_created_at_returns_the_time_instance_for_the_date_the_invoice_wasa_created
     assert_equal Time.parse(“2015-07-10 00:00:00 -0600”), @invoice.created_at
     assert_equal Time, @invoice.created_at.class
   end
