require_relative 'test_helper'
require_relative '../lib/invoice'
require 'time'

class InvoiceTest < Minitest::Test

  def setup
    data = {
      id:           6,
      customer_id:  7,
      merchant_id:  8,
      status:       "pending",
      created_at:   "2018-02-02 14:37:20 -0700",
      updated_at:   "2018-02-02 14:37:20 -0700"}
    @invoice = Invoice.new(data)
  end

  def test_if_it_exists
    assert_instance_of Invoice, @invoice
  end

  def test_if_it_has_attributes
    assert_equal 6, @invoice.id
    assert_equal 7, @invoice.customer_id
    assert_equal 8, @invoice.merchant_id
    assert_equal :pending, @invoice.status
    assert @invoice.created_at.class == Time
    assert @invoice.updated_at.class == Time
  end

end
