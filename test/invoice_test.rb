require_relative 'test_helper'
require './lib/invoice'
class InvoiceTest < Minitest::Test

  def test_exists
    skip
    invoice = Invoice.new({ :id => 6,
                            :customer_id => 7,
                            :merchant_id => 8,
                            :status      => "pending",
                            :created_at  => Time.now.to_s,
                            :updated_at  => Time.now.to_s
                            }, nil)

    assert_instance_of Invoice, invoice
  end

  def test_it_returns_intialized_state
    skip
    invoice = Invoice.new({ :id => 6,
                            :customer_id => 7,
                            :merchant_id => 8,
                            :status      => "pending",
                            :created_at  => Time.now,
                            :updated_at  => Time.now
                            }, nil)

      assert_equal 6, invoice.id
      assert_equal 7, invoice.customer_id
      assert_equal 8, invoice.merchant_id
      assert_equal "pending", invoice.status
      # assert_equal 3, invoice.created_at
      # assert_equal 4, invoice.updated_at
  end
end
