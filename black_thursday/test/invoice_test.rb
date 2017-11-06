require_relative 'test_helper'
require 'time'
require_relative './../lib/invoice'
require_relative './../lib/sales_engine'

class InvoiceTest < Minitest::Test

  attr_reader :invoice

  def setup
    @se = SalesEngine.new({:items => "./test/fixtures/truncated_items.csv",
                         :merchants => "./test/fixtures/truncated_merchants.csv",
                         :invoices => "./test/fixtures/truncated_invoices.csv",
                         :invoice_items => "./test/fixtures/truncated_invoice_items.csv",
                         :transactions => "./test/fixtures/truncated_customers.csv",
                         :customers =>  "./test/fixtures/truncated_transactions.csv"})
    @repository = InvoiceRepository.new("./test/fixtures/truncated_invoices.csv" , @se)
    @invoice = Invoice.new({id: "1", customer_id: "1", merchant_id: "12335938", status: "pending", created_at: "2009-02-07", updated_at: "2014-03-15"}, @repository)
  end

  def test_if_class_exists
    assert_instance_of Invoice, invoice
  end

  def test_it_returns_correct_attributes
    assert_equal 1, @invoice.id
    assert_equal 1, @invoice.customer_id
    assert_equal 12335938, @invoice.merchant_id
    assert_equal :pending, @invoice.status
    assert_equal DateTime.parse('2009-02-07 00:00:00 -0700').to_time, @invoice.created_at
    assert_equal DateTime.parse('2014-03-15 00:00:00 -0600').to_time, @invoice.updated_at
  end

  def test_is_paid_in_full
    assert_equal false, @invoice.is_paid_in_full?
    invoice = Invoice.new({id: "46", customer_id: "10", merchant_id: "12336837", status: "shipped", created_at: "2005-11-11", updated_at: "2015-05-03"}, @repository)
    assert_equal false, invoice.is_paid_in_full?
  end

  def test_total
    assert_equal 0, @invoice.total
    invoice = Invoice.new({id: "46", customer_id: "10", merchant_id: "12336837", status: "shipped", created_at: "2005-11-11", updated_at: "2015-05-03"}, @repository)
    assert_equal 0, invoice.total
  end

  def test_can_find_invoice_items_by_id_and_returns_array
    assert_instance_of Array, @invoice.invoice_items
    assert_equal 8, @invoice.invoice_items.length
    assert_equal 1, @invoice.invoice_items.first.id
  end

  def test_transactions
    assert_equal [], invoice.transactions
  end

  def test_items
    assert_equal 1, invoice.items.compact.length
    assert_instance_of Item, invoice.items.compact.first
    assert_equal 8, invoice.items.length
  end

  def test_merchant
    assert_equal '', invoice.merchant
  end
end
