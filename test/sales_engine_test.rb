# frozen_string_literal: true

require_relative 'test_helper'
require './lib/sales_engine'
require 'pry'

# This is a SalesEngineTest Class
class SalesEngineTest < Minitest::Test
  def setup
    @se = SalesEngine.from_csv(
      {
        items:         './test/fixtures/items_truncated.csv',
        merchants:     './test/fixtures/merchants_truncated.csv',
        invoices:      './test/fixtures/invoices_truncated.csv',
        invoice_items: './test/fixtures/invoice_items_truncated.csv',
        transactions:  './test/fixtures/transactions_truncated.csv',
        customers:     './test/fixtures/customers_truncated.csv'
      } )
      # {
      #   items:         './data/items.csv',
      #   merchants:     './data/merchants.csv',
      #   invoices:      './data/invoices.csv',
      #   invoice_items: './data/invoice_items.csv',
      #   transactions:  './data/transactions.csv',
      # } )
  end

  def test_it_exists
    assert_instance_of SalesEngine, @se
  end

  def test_it_loads_csv_data
    assert_instance_of ItemRepository, @se.items
    assert_instance_of MerchantRepository, @se.merchants
    assert_instance_of InvoiceRepository, @se.invoices
    assert_instance_of InvoiceItemRepository, @se.invoice_items
    assert_instance_of TransactionRepository, @se.transactions
    assert_instance_of CustomerRepository, @se.customers
  end

  def test_it_can_access_items
    assert_instance_of Item, @se.items.find_by_name('Disney scrabble frames')
  end

  def test_it_can_access_merchants
    assert_instance_of Merchant, @se.merchants.find_by_name('Heiline')
  end

  def test_it_can_access_invoices
    assert_instance_of Invoice, @se.invoices.find_by_id(1)
  end

  def test_it_can_access_invoice_items
    assert_instance_of InvoiceItem, @se.invoice_items.find_by_id(6)
  end

  def test_it_can_access_transactions
    assert_instance_of Transaction, @se.transactions.find_by_id(6)
  end

  def test_it_can_access_customers
    assert_instance_of Customer, @se.customers.find_by_id(6)
  end

  def test_sales_engine_can_return_an_analyst
    assert_instance_of SalesAnalyst, @se.analyst
  end
end
