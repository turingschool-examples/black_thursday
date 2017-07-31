require 'simplecov'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/invoice'

class InvoiceTest < Minitest::Test

  def setup
    @invoice = Invoice.new({
                            :id          => 6,
                            :customer_id => 7,
                            :merchant_id => 8,
                            :status      => "pending",
                            :created_at  => "2009-02-07",
                            :updated_at  => "2014-03-15"
                            }, "InvoiceRepository")
  end

  def test_it_exists_and_has_attributes
    assert_instance_of Invoice, @invoice
    assert_equal 6, @invoice.id
    assert_equal 7, @invoice.customer_id
    assert_equal 8, @invoice.merchant_id
    assert_equal "pending", @invoice.status
    assert_instance_of Time, @invoice.created_at
    assert_instance_of Time, @invoice.updated_at
  end

  def test_invoice_can_get_merchant
    assert_instance_of Merchant, @invoice.merchant
  end

end
