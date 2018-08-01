# frozen_string_literal: true

require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/invoice'

class InvoiceTest < Minitest::Test
  def setup
    @invoice = Invoice.new(id: 1,
                           customer_id: 1,
                           merchant_id: 12_335_938,
                           status: 'pending',
                           created_at: '2009-02-07',
                           updated_at: '2014-03-15')
  end

  def test_it_exists
    assert_instance_of Invoice, @invoice
  end

  def test_it_has_attributes
    assert_equal 1, @invoice.id
    assert_equal 1, @invoice.customer_id
    assert_equal 12_335_938, @invoice.merchant_id
    assert_equal :pending, @invoice.status
    assert_equal Time.parse('2009-02-07'), @invoice.created_at
    assert_equal Time.parse('2014-03-15'), @invoice.updated_at
  end

  def test_it_returns_created_string
    assert_equal '2009-02-07', @invoice.created_string
  end

  def it_can_create_with_create
    created_invoice = Invoice.create(customer_id: 2,
                                     merchant_id: 12_335_999,
                                     status: 'pending',
                                     created_at: '2009-02-07',
                                     updated_at: '2014-03-15')
    assert_instance_of Invoice, created_invoice
  end
end
