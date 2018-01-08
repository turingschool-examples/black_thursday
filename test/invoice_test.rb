require_relative 'test_helper'
require_relative '../lib/invoice'

class InvoiceTest < Minitest::Test
  def setup
    @invoices = mock("invoicerepository")
    @invoice = Invoice.new({id: 1,
                    customer_id: 3,
                    merchant_id: 12335938,
                    status: "pending",
                    created_at: Time.now.inspect,
                    updated_at: Time.now.inspect}, @invoices)
  end

  def test_it_exists
    assert_instance_of Invoice, @invoice
  end

  def test_it_has_an_id
    assert_equal 1, @invoice.id
  end

  def test_it_has_a_customer_id
    assert_equal 3, @invoice.customer_id
  end

  def test_it_has_a_merchant_id
    assert_equal 12335938, @invoice.merchant_id
  end

  def test_it_has_a_status
    assert_equal "pending", @invoice.status
  end

  def test_it_has_a_created_at
    assert_equal Time.now.inspect, @invoice.created_at.inspect
  end

  def test_it_has_an_updated_at
    assert_equal Time.now.inspect, @invoice.updated_at.inspect
  end

  def test_it_calls_its_parent_to_find_its_items
    item = mock('item')
    @invoices.expects(:find_items_by_invoice_id).returns([item, item])

    assert_equal [item, item], @invoice.items
  end

  def test_it_calls_its_parent_to_find_its_transactions
    transaction = mock('transaction')
    @invoices.expects(:find_transactions_by_invoice_id).returns([transaction, transaction])

    assert_equal [transaction, transaction], @invoice.transactions
  end
end
