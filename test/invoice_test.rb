require './test/test_helper'
require './lib/invoice'
# require 'bigdecimal'

class InvoiceTest < Minitest::Test

  def setup
    @i = Invoice.new({
      :id          => 6,
      :customer_id => 7,
      :merchant_id => 8,
      :status      => "pending",
      :created_at  => Time.now,
      :updated_at  => Time.now,
    })
  end

  def test_invoice_kind_of?

  end

  def test_invoice_initializes_with_id
    id = 6
    assert_equal id, @i.id
  end

  def test_invoice_initializes_with_customer_id
    customer_id = 7
    assert_equal customer_id, @i.customer_id
  end

  def test_invoice_initializes_with_merchant_id
    merchant_id = 8
    assert_equal merchant_id, @i.merchant_id
  end

  def test_invoice_initializes_with_status
    status  = "pending"
    assert_equal status, @i.status
  end

  def test_item_initializes_with_created_at
    skip
    created_at  = Time.now
    assert_equal created_at, @i.created_at
  end

end
