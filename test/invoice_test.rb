require './test/test_helper'
require './lib/invoice'

# Tests the invoice class
class InvoiceTest < Minitest::Test
  def setup
    merchant     = mock
    invoice_repo = stub(merchant: merchant)
    @invoice = Invoice.new({id: 6,
                   customer_id: 7,
                   merchant_id: 8,
                        status: 'pending',
                    created_at: '1969-07-20 20:17:40 - 0600',
                    updated_at: '1969-07-20 20:17:40 - 0600'},
                    invoice_repo)
  end

  def test_it_exists
    assert_instance_of Invoice, @invoice
  end

  def test_it_has_attributes
    assert_equal 6, @invoice.id
    assert_equal 7, @invoice.customer_id
    assert_equal 8, @invoice.merchant_id
    assert_equal :pending, @invoice.status
    assert_equal '1969-07-20 20:17:40 -0600', @invoice.created_at.to_s
    assert_equal '1969-07-20 20:17:40 -0600', @invoice.updated_at.to_s
  end

  def test_data_types_of_attributes
    assert_instance_of Integer, @invoice.id
    assert_instance_of Integer, @invoice.customer_id
    assert_instance_of Integer, @invoice.merchant_id
    assert_instance_of Symbol, @invoice.status
    assert_instance_of Time, @invoice.created_at
    assert_instance_of Time, @invoice.updated_at
  end

  def test_it_asks_parent_for_merchant
    assert_instance_of Mocha::Mock, @invoice.merchant
  end

  def test_it_asks_parent_for_customer
    skip
    assert_instance_of Mocha::Mock, @invoice.customer
  end
end
