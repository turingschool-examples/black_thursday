require_relative 'test_helper'
require_relative '../lib/invoice'
require_relative '../lib/sales_engine'

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

  def information
    {
      items: './test/fixtures/items_list_truncated.csv',
      merchants: './test/fixtures/merchants_list_truncated.csv',
      invoices: './test/fixtures/invoices_list_truncated.csv',
      invoice_items: './test/fixtures/invoice_items_list_truncated.csv',
      transactions: './test/fixtures/transactions_list_truncated.csv',
      customers: './test/fixtures/customer_list_truncated.csv'
    }
  end

  def test_it_exists
    assert_instance_of Invoice, @invoice
  end

  def test_attributes_set_correctly
    assert_equal 'ItemRepository pointer', @invoice.parent
    assert_equal 1, @invoice.id
    assert_equal 1, @invoice.customer_id
    assert_equal 123_359_38, @invoice.merchant_id
    assert_equal :pending, @invoice.status
    assert_equal Time.new(2009, 0o2, 0o7), @invoice.created_at
    assert_equal Time.new(2014, 0o3, 15), @invoice.updated_at
  end

  def test_finding_merchant_associated_with_invoice
    sales_engine = SalesEngine.from_csv(information)
    invoice = sales_engine.invoices.find_by_id(20)

    assert_instance_of Merchant, invoice.merchant
    assert_equal 123_361_63, invoice.merchant.id
  end

  def test_finding_items_associated_with_invoice
    sales_engine = SalesEngine.from_csv(information)
    invoice = sales_engine.invoices.find_by_id(19)

    assert_instance_of Array, invoice.items
    assert_instance_of Item, invoice.items[0]
    assert_equal 263_504_126, invoice.items[0].id
  end

  def test_finding_transactions_associated_with_invoice
    sales_engine = SalesEngine.from_csv(information)
    invoice = sales_engine.invoices.find_by_id(19)

    assert_instance_of Array, invoice.transactions
    assert_instance_of Transaction, invoice.transactions[0]
    assert_equal 587, invoice.transactions[0].id
  end

  def test_finding_customer_associated_with_invoice
    sales_engine = SalesEngine.from_csv(information)
    invoice = sales_engine.invoices.find_by_id(19)

    assert_instance_of Customer, invoice.customer
    assert_equal 5, invoice.customer.id
  end

  def test_is_paid_in_full?
    sales_engine = SalesEngine.from_csv(information)

    assert sales_engine.invoices.find_by_id(19).is_paid_in_full?
    refute sales_engine.invoices.find_by_id(4702).is_paid_in_full?
  end

  def test_total
    sales_engine = SalesEngine.from_csv(information)
    invoice = sales_engine.invoices.find_by_id(19)

    assert invoice.is_paid_in_full?
    assert_equal 2446.02, invoice.total
  end

  def test_finding_invoice_items_associated_with_invoice
    sales_engine = SalesEngine.from_csv(information)
    invoice = sales_engine.invoices.find_by_id(19)

    assert_instance_of Array, invoice.invoice_items
    assert_instance_of InvoiceItem, invoice.invoice_items[0]
    assert_equal 95, invoice.invoice_items[0].id
  end
end
