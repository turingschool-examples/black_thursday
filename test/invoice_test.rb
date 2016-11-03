require_relative 'test_helper'
require_relative '../lib/invoice'

class InvoiceTest < Minitest::Test

  attr_reader :invoice

  def setup
    @invoice = Invoice.new({
      :id => '6',
      :customer_id => '7',
      :merchant_id => '8',
      :status => "pending",
      :created_at => Time.now.to_s,
      :updated_at => Time.now.to_s},
      Minitest::Mock.new)
  end

  def test_invoice_exists
    assert invoice
  end
  
  def test_invoice_knows_its_id
    assert_equal 6, invoice.id
  end

  def test_invoice_knows_its_customer_id
    assert_equal 7, invoice.customer_id
  end

  def test_invoice_knows_its_merchant_id
    assert_equal 8, invoice.merchant_id
  end

  def test_invoice_knows_its_status
    assert_equal :pending, invoice.status
  end

  def test_invoice_knows_time_created_at
    assert_equal Time.now.to_s, invoice.created_at.to_s
  end

  def test_invoice_knows_time_updated_at
    assert_equal Time.now.to_s, invoice.updated_at.to_s
  end

  def test_invoice_calls_parent
    invoice.parent.expect(:find_merchant, nil, [8])
    invoice.merchant
    invoice.parent.verify
  end

end