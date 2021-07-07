# frozen_string_literal: false

require_relative 'test_helper'
require './lib/sales_engine'

class SalesEngineTest < Minitest::Test
  def setup
    @file_paths = { items: './data/items.csv',
                    merchants: './data/merchants.csv',
                    invoices: './data/invoices.csv',
                    invoice_items: './data/invoice_items.csv',
                    customers: './data/customers.csv',
                    transactions: './data/transactions.csv' }
    @se = SalesEngine.new(@file_paths)
  end

  def test_it_exists
    assert_instance_of SalesEngine, @se
  end

  def test_it_can_load_the_file
    assert_instance_of ItemRepository, @se.items
    assert_instance_of MerchantRepository, @se.merchants
    assert_instance_of InvoiceRepository, @se.invoices
    assert_instance_of InvoiceItemRepository, @se.invoice_items
    assert_instance_of CustomerRepository, @se.customers
    assert_instance_of TransactionRepository, @se.transactions
    assert_instance_of SalesAnalyst, @se.analyst
  end
end
