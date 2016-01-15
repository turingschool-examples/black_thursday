require 'minitest'
require 'minitest/pride'
require './lib/invoice'

class InvoiceTest < Minitest::Test
attr_reader :invoice
  def setup
    @invoice = Invoice.new({:id => 1, :created_at => "2012-03-27 14:53:59 UTC", :updated_at => "2012-03-27 14:53:59 UTC", :customer_id => 123456, :merchant_id => 2, :status => "shipping"})
  end

  def test_invoice_can_be_initialized
    assert_equal Invoice, invoice.class
  end

  def test_invoice_can_generate_an_id
    assert_equal 1, invoice.id
  end

  def test_invoice_can_pull_updated_at
    expected = Time.new("2012-03-27 14:53:59 UTC")
    assert_equal expected, invoice.updated_at
  end

  def test_invoice_can_pull_created_at
    expected = Time.new("2012-03-27 14:53:59 UTC")
    assert_equal expected , invoice.created_at
  end

  def test_invoice_can_pull_merchant_id
    assert_equal 2, invoice.merchant_id
  end

  def test_invoice_can_pull_status
    assert_equal :shipping, invoice.status
  end
end
