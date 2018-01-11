require_relative 'test_helper'
require_relative '../lib/invoice'

class InvoiceTest < Minitest::Test
  def setup
    @item = mock('item')
    @transaction = mock("Transaction")
    @invoice_item = stub(:total_cost => 1300)
    @invoices = stub(:find_transactions_by_invoice_id => [@transaction],
                     :find_invoice_items_by_invoice_id => [@invoice_item, @invoice_item],
                     :find_items_by_invoice_id => [@item, @item])
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
    assert_equal [@item, @item], @invoice.items
  end

  def test_it_calls_its_parent_to_find_its_transactions
    assert_equal [@transaction], @invoice.transactions
  end

  def test_it_calls_its_parent_to_find_its_customer
    customer = mock('customer')
    @invoices.expects(:find_customer_by_customer_id).returns(customer)

    assert_equal customer, @invoice.customer
  end

  def test_it_returns_whether_invoice_is_paid_in_full
    invoice_item = mock('invoice_item')
    @transaction.expects(:result).returns("success")
    invoice_repository = stub(:find_transactions_by_invoice_id => [@transaction],
                              :find_invoice_items_by_invoice_id => [invoice_item])

    invoice = Invoice.new(@data, invoice_repository)

    assert invoice.is_paid_in_full?
  end

  def test_it_returns_false_if_invoice_is_not_paid_in_full
    @transaction.expects(:result).returns("failure")

    refute @invoice.is_paid_in_full?
  end

  def test_it_returns_total_amount_of_invoice
    assert_equal 2600, @invoice.total
  end

  def test_weekday_returns_day_of_the_week_it_was_created_at
    assert_equal Time.now.strftime('%A'), @invoice.weekday
  end
end
