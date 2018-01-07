require './test/test_helper'
require './lib/invoice'

class InvoiceTest < Minitest::Test
  def setup
    @invoice = Invoice.new({
      :id          => 6,
      :customer_id => 7,
      :merchant_id => 8,
      :status      => "pending",
      :created_at  => "2014-03-15",
      :updated_at  => "2014-03-15",
    })
  end

  def test_it_calls_instance_variables
    assert_equal 6, @invoice.id
    assert_equal 7, @invoice.customer_id
    assert_equal 8, @invoice.merchant_id
    assert_equal :pending, @invoice.status
    assert_instance_of Time, @invoice.created_at
    assert_instance_of Time, @invoice.updated_at
  end

  def test_it_can_return_merchant
    skip 
    parent = mock('merchant_repository')
    parent.expects(:merchant).returns("Merchant")


    assert_equal "Merchant", @invoice.merchant
  end
end
