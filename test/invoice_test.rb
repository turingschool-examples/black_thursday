require_relative 'test_helper'
require_relative '../lib/invoice'

class InvoiceTest < Minitest::Test
  def setup
    @data = {
      id: 1,
      customer_id: 1,
      merchant_id: 123_359_38,
      status: 'pending',
      created_at: '2009-02-07',
      updated_at: '2014-03-15'
    }
    @invoice = Invoice.new(@data, 'ItemRepository pointer')
  end

  def test_it_exists
    assert_instance_of Invoice, @invoice
  end

  def test_attributes_set_correctly
    assert_equal 'ItemRepository pointer', @invoice.parent
    assert_equal 1, @invoice.id
    assert_equal 1, @invoice.customer_id
    assert_equal 123_359_38, @invoice.merchant_id
    assert_equal 'pending', @invoice.status
    assert_equal '2009-02-07', @invoice.created_at
    assert_equal '2014-03-15', @invoice.updated_at
  end
end
