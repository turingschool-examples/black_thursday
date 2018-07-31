require_relative './test_helper'
require './lib/invoice'

class InvoiceTest < Minitest::Test

  def test_it_exists
    invoice = Invoice.new(
      {id: 1,
      customer_id: 1,
      merchant_id: 1111,
      status: 'shipped',
      created_at: '2010-11-10',
      updated_at: '2011-11-04'}
      )

    assert_instance_of Invoice, invoice
  end

  def test_it_has_attributes
    invoice = Invoice.new(
      {id: 1,
      customer_id: 1,
      merchant_id: 1111,
      status: 'shipped',
      created_at: '2010-11-10',
      updated_at: '2011-11-04'}
      )

    assert_equal 1, invoice.id
    assert_equal 1, invoice.customer_id
    assert_equal 1111, invoice.merchant_id
    assert_equal :shipped, invoice.status
    assert_equal Time, invoice.created_at.class
    assert_equal Time, invoice.updated_at.class
  end

end
