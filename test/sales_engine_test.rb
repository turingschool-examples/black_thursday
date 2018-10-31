require_relative 'test_helper'

require_relative '../lib/sales_engine'

class SalesEngineTest < Minitest::Test
  # def setup
  #   @se = SalesEngine.from_csv({
  #     items: './data/items.csv',
  #     merchants: './data/merchants.csv',
  #     invoices: './data/invoices.csv',
  #     invoice_items: './data/invoice_items.csv',
  #     transactions: './data/transactions.csv',
  #     customers: './data/customers.csv'
  #   })
  # end
  #
  # def test_it_exists
  #   assert_instance_of SalesEngine, @se
  # end
  #
  # def test_it_holds_an_item_repository
  #   assert_instance_of ItemRepository, @se.items
  # end
  #
  # def test_it_holds_a_merchant_repository
  #   assert_instance_of MerchantRepository, @se.merchants
  # end
  #
  # def test_it_holds_an_invoice_repository
  #   assert_instance_of InvoiceRepository, @se.invoices
  # end
  #
  # def test_it_holds_an_invoice_items_repository
  #   assert_instance_of InvoiceItemRepository, @se.invoice_items
  # end
  #
  # def test_it_holds_an_customer_repository
  #   assert_instance_of CustomerRepository, @se.customers
  # end
  #
  # def test_it_holds_an_transaction_repository
  #   assert_instance_of TransactionRepository, @se.transactions
  # end
  #
  # def test_it_parses_items_correctly
  #   assert_equal 34, @se.items.all.length
  # end
  #
  # def test_it_parses_invoices_correctly
  #   assert_equal 73, @se.invoices.all.length
  # end
  #
  # def test_it_parses_merchants_correctly
  #   assert_equal 7, @se.merchants.all.length
  # end
  #
  # def test_it_parses_invoice_items_correctly
  #   assert_equal 319, @se.invoice_items.all.length
  # end
  #
  # def test_it_parses_customers_correctly
  #   assert_equal 68, @se.customers.all.length
  # end
  #
  # def test_it_parses_transactions_correctly
  #   assert_equal 69, @se.transactions.all.length
  # end
end
