# frozen_string_literal: false

require_relative 'test_helper'
require './lib/invoice'

class InvoiceTest < Minitest::Test
  def setup
    @args = {
      id:          '456',
      customer_id: '34567',
      merchant_id: '3456789',
      status:      'pending',
      created_at:  '2016-01-11 09:34:06 UTC',
      updated_at:  '2007-06-04 21:35:10 UTC'
    }
    @invoice = Invoice.new(@args)
  end

  def test_it_exists
    assert_instance_of Invoice, @invoice
  end

  def test_it_has_attributes
    assert_equal 456, @invoice.id
    assert_equal 34_567, @invoice.customer_id
    assert_equal 3_456_789, @invoice.merchant_id
    assert_equal :pending, @invoice.status
  end

  def test_time_attributes_for_created
    assert_instance_of Time, @invoice.created_at
    assert_equal 2016, @invoice.created_at.year
    assert_equal 34, @invoice.created_at.min
  end

  def test_time_attributes_for_updated
    assert_instance_of Time, @invoice.updated_at
    assert_equal 0o6, @invoice.updated_at.mon
    assert_equal 21, @invoice.updated_at.hour
  end
end
