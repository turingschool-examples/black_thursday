require_relative './test_setup'
require './lib/sales_engine'
require './lib/finders'
require 'minitest/autorun'
require 'minitest/pride'
require 'pry'


class FindersTest < Minitest::Test

  include TestSetup


  def test_it_can_find_invoices_from_anything
    skip
    setup_big_data_set
    actual = @sa.find_invoices_from(@sa.merchants.all[0])
    assert_instance_of Invoice, actual[0]
    assert_equal 74, actual[0].id
    actual = @sa.find_invoices_from(@sa.items.all[0])
    assert_instance_of Invoice, actual[0]
    assert_equal 3, actual[0].id
    actual = @sa.find_invoices_from(@sa.invoice_items.all[0])
    assert_instance_of Invoice, actual[0]
    assert_equal 1, actual[0].id
    actual = @sa.find_invoices_from(@sa.transactions.all[0])
    assert_instance_of Invoice, actual[0]
    assert_equal 2179, actual[0].id
    actual = @sa.find_invoices_from(@sa.customers.all[0])
    assert_instance_of Invoice, actual[0]
    assert_equal 1, actual[0].id
    actual = @sa.find_invoices_from(@sa.invoices.all[0])
    assert_instance_of Invoice, actual[0]
    assert_equal 1, actual[0].id
    # assert_equal 21067.77, @sa.revenue_from_invoice(@sa.invoices.all[0])
  end

  def test_find_from_invoice_can_find_anything_from_invoice
    setup_big_data_set
    invoice = @sa.invoices.all[0]
    actual = @sa.find_from_invoice(invoice, 'InvoiceItem')
    assert_equal 8, actual.size
    assert_instance_of InvoiceItem, actual[0]
    actual = @sa.find_from_invoice(invoice, 'Transaction')
    assert_equal 2, actual.size
    assert_instance_of Transaction, actual[0]
    actual = @sa.find_from_invoice(invoice, 'Merchant')
    assert_equal 1, actual.size
    assert_instance_of Merchant, actual[0]
    actual = @sa.find_from_invoice(invoice, 'Customer')
    assert_equal 1, actual.size
    assert_instance_of Customer, actual[0]
    actual = @sa.find_from_invoice(invoice, 'Item')
    assert_equal 8, actual.size
    assert_instance_of Item, actual[0]

  end
end
