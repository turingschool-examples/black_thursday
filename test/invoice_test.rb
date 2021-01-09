
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
