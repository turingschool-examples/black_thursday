require_relative 'test_helper'
require_relative '../lib/customer'
require_relative '../lib/sales_engine'
require 'time'

class CustomerTest < Minitest::Test
  def setup
    @data = {
      id: 6,
      first_name: 'Joan',
      last_name: 'Clarke',
      created_at: '2012-03-27 14:54:09 UTC',
      updated_at: '2012-03-27 14:54:09 UTC'
    }
    @customer = Customer.new(@data, 'CustomerRepository pointer')
  end

  def test_it_exists
    assert_instance_of Customer, @customer
  end

  def test_it_initializes_with_information
    assert_equal 6, @customer.id
    assert_equal 'Joan', @customer.first_name
    assert_equal 'Clarke', @customer.last_name
    assert_equal Time.utc(2012, 3, 27, 14, 54, 9), @customer.created_at
    assert_equal Time.utc(2012, 3, 27, 14, 54, 9), @customer.updated_at
    assert_equal 'CustomerRepository pointer', @customer.parent
  end

  def test_finding_merchants_associated_with_customer
    information = {
      items: './test/fixtures/items_list_truncated.csv',
      merchants: './test/fixtures/merchants_list_truncated.csv',
      invoices: './test/fixtures/invoices_list_truncated.csv',
      invoice_items: './test/fixtures/invoice_items_list_truncated.csv',
      transactions: './test/fixtures/transactions_list_truncated.csv',
      customers: './test/fixtures/customer_list_truncated.csv'
    }
    sales_engine = SalesEngine.from_csv(information)
    customer = sales_engine.customers.find_by_id(51)

    assert_instance_of Array, customer.merchants
    assert_instance_of Merchant, customer.merchants[0]
    assert_equal 12_334_112, customer.merchants[0].id
  end

  def test_finding_fully_paid_invoices_associated_with_customer
    information = {
      items: './test/fixtures/items_list_truncated.csv',
      merchants: './test/fixtures/merchants_list_truncated.csv',
      invoices: './test/fixtures/invoices_list_truncated.csv',
      invoice_items: './test/fixtures/invoice_items_list_truncated.csv',
      transactions: './test/fixtures/transactions_list_truncated.csv',
      customers: './test/fixtures/customer_list_truncated.csv'
    }
    sales_engine = SalesEngine.from_csv(information)
    customer = sales_engine.customers.find_by_id(14)

    assert_instance_of Array, customer.fully_paid_invoices
    assert_instance_of Invoice, customer.fully_paid_invoices[0]
    assert_equal 74, customer.fully_paid_invoices[0].id
  end

  def test_finding_all_invoices_associated_with_customer
    information = {
      items: './test/fixtures/items_list_truncated.csv',
      merchants: './test/fixtures/merchants_list_truncated.csv',
      invoices: './test/fixtures/invoices_list_truncated.csv',
      invoice_items: './test/fixtures/invoice_items_list_truncated.csv',
      transactions: './test/fixtures/transactions_list_truncated.csv',
      customers: './test/fixtures/customer_list_truncated.csv'
    }
    sales_engine = SalesEngine.from_csv(information)
    customer = sales_engine.customers.find_by_id(14)

    assert_instance_of Array, customer.all_invoices
    assert_instance_of Invoice, customer.all_invoices[0]
    assert_equal 74, customer.all_invoices[0].id
  end

  def test_finding_items_associated_with_customer
    information = {
      items: './test/fixtures/items_list_truncated.csv',
      merchants: './test/fixtures/merchants_list_truncated.csv',
      invoices: './test/fixtures/invoices_list_truncated.csv',
      invoice_items: './test/fixtures/invoice_items_list_truncated.csv',
      transactions: './test/fixtures/transactions_list_truncated.csv',
      customers: './test/fixtures/customer_list_truncated.csv'
    }
    sales_engine = SalesEngine.from_csv(information)
    customer = sales_engine.customers.find_by_id(14)

    assert_instance_of Array, customer.items
    assert_instance_of Item, customer.items[0]
    assert_equal 263_506_360, customer.items[0].id
  end

  def test_finding_paid_invoice_items_associated_with_customer
    information = {
      items: './test/fixtures/items_list_truncated.csv',
      merchants: './test/fixtures/merchants_list_truncated.csv',
      invoices: './test/fixtures/invoices_list_truncated.csv',
      invoice_items: './test/fixtures/invoice_items_list_truncated.csv',
      transactions: './test/fixtures/transactions_list_truncated.csv',
      customers: './test/fixtures/customer_list_truncated.csv'
    }
    sales_engine = SalesEngine.from_csv(information)
    customer = sales_engine.customers.find_by_id(14)

    assert_instance_of Array, customer.fully_paid_invoice_items
    assert_instance_of InvoiceItem, customer.fully_paid_invoice_items[0]
    assert_equal 344, customer.fully_paid_invoice_items[0].id
  end

  def test_finding_all_invoice_items_associated_with_customer
    information = {
      items: './test/fixtures/items_list_truncated.csv',
      merchants: './test/fixtures/merchants_list_truncated.csv',
      invoices: './test/fixtures/invoices_list_truncated.csv',
      invoice_items: './test/fixtures/invoice_items_list_truncated.csv',
      transactions: './test/fixtures/transactions_list_truncated.csv',
      customers: './test/fixtures/customer_list_truncated.csv'
    }
    sales_engine = SalesEngine.from_csv(information)
    customer = sales_engine.customers.find_by_id(14)

    assert_instance_of Array, customer.all_invoice_items
    assert_instance_of InvoiceItem, customer.all_invoice_items[0]
    assert_equal 344, customer.all_invoice_items[0].id
  end
end
