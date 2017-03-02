require './test/test_helper'

class InvoiceRepositoryTest < Minitest::Test

  attr_reader :ir, :invoices, :invoice_1, :invoice_2, :invoice_3

  def setup
    @invoice_1 = Invoice.new(id:"2", customer_id:"1", merchant_id:"12334753", status:"shipped", created_at:"2012-11-23", updated_at:"2013-04-14")
    @invoice_2 = Invoice.new(id:"8", customer_id:"1", merchant_id:"12337139", status:"shipped", created_at:"2003-11-07", updated_at:"2004-07-31")
    @invoice_3 = Invoice.new(id:"16",customer_id:"5", merchant_id:"12336113", status:"shipped", created_at:"2014-07-26", updated_at:"2014-08-25")
    @invoices  = [invoice_1, invoice_2, invoice_3]
    @ir        = InvoiceRepository.new(invoices)
  end

  def test_it_exists
    assert_instance_of InvoiceRepository, InvoiceRepository.new(invoices)
  end

  def test_all
    assert_equal invoices, ir.all
  end

  def test_find_by_id
    assert_equal invoice_2, ir.find_by_id(8)
  end

  def test_find_all_by_customer_id
    assert_equal [invoice_1, invoice_2], ir.find_all_by_customer_id(1)
  end

  def test_find_all_by_merchant_id
    assert_equal [invoice_3], ir.find_all_by_merchant_id(12336113)
  end

  def test_find_all_by_status
    assert_equal [invoice_1, invoice_2, invoice_3], ir.find_all_by_status("shipped")
  end
end