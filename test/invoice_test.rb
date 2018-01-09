require_relative 'test_helper'
require_relative '../lib/invoice'

class InvoiceTest < Minitest::Test
  def setup
    @invoices = mock("invoicerepository")
    @data = {id: 1,
            customer_id: 3,
            merchant_id: 12335938,
            status: "pending",
            created_at: Time.now.inspect,
            updated_at: Time.now.inspect}
    @invoice = Invoice.new(@data, @invoices)
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
    assert_equal :pending, @invoice.status
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

  def test_it_calls_its_parent_to_find_its_customer
    customer = mock('customer')
    @invoices.expects(:find_customer_by_customer_id).returns(customer)

    assert_equal customer, @invoice.customer
  end

  def test_it_returns_whether_invoice_is_paid_in_full
    transaction = stub(:result => "success")
    invoice_repository = stub(:find_transactions_by_invoice_id => [transaction, transaction])
    invoice = Invoice.new(@data, invoice_repository)

    assert invoice.is_paid_in_full?
  end

  def test_it_returns_false_if_invoice_is_not_paid_in_full
    transaction_1 = stub(:result => "success")
    transaction_2 = stub(:result => "failure")
    @invoices.expects(:find_transactions_by_invoice_id).returns([transaction_1, transaction_2])

    refute @invoice.is_paid_in_full?
  end

  def test_it_returns_total_amount_of_invoice
    invoice_item_1 = stub(:total_cost => 1300)
    invoice_item_2 = stub(:total_cost => 1200)
    @invoices.expects(:find_invoice_items_by_invoice_id).returns([invoice_item_1, invoice_item_2])

    assert_equal 2500, @invoice.total
  end

  def test_weekday_returns_day_of_the_week_it_was_created_at
    assert_equal "Tuesday", @invoice.weekday
  end
end
