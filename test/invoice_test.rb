require_relative 'test_helper'
require './lib/invoice'

class InvoiceTest < Minitest::Test

  def setup
    @args = {
      :id          => '456',
      :customer_id => '34567',
      :merchant_id => '3456789',
      :status      => 'pending',
      :created_at  => '2016-01-11 09:34:06 UTC',
      :updated_at  => '2007-06-04 21:35:10 UTC'
    }
    @invoice = Invoice.new(@args)
  end

  def test_it_exists
    assert_instance_of Invoice, @invoice
  end

  def test_it_has_attributes
    assert_instance_of Fixnum, @invoice.id
    assert_instance_of Fixnum, @invoice.customer_id
    assert_instance_of Fixnum, @invoice.merchant_id
    assert_instance_of Symbol, @invoice.status
    assert_instance_of Time, @invoice.created_at
    assert_instance_of Time, @invoice.updated_at
  end
end
