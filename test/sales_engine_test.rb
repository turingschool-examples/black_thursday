require_relative 'test_helper'
require_relative '../lib/sales_engine'
require_relative '../lib/repositories/customer_repository'
require_relative '../lib/repositories/invoice_item_repository'
require_relative '../lib/repositories/invoice_repository'
require_relative '../lib/repositories/item_repository'
require_relative '../lib/repositories/merchant_repository'
require_relative '../lib/repositories/transaction_repository'

# Test for the SalesEngine class
class SalesEngineTest < Minitest::Test
  def setup
    @sales_engine = SalesEngine.from_csv(
      customers: './test/fixtures/test_customers.csv',
      invoices: './test/fixtures/test_invoices.csv',
      invoice_items: './test/fixtures/test_invoice_items.csv',
      items: './test/fixtures/test_items0.csv',
      merchants: './test/fixtures/test_merchants0.csv',
      transactions: './test/fixtures/test_transactions.csv'
    )
  end

  def test_sales_engine_exists
    assert_instance_of SalesEngine, @sales_engine
  end

  def test_sales_engine_customer_is_customer_repo
    assert_instance_of CustomerRepository, @sales_engine.customers
  end

  def test_sales_engine_invoices_is_invoice_repo
    assert_instance_of InvoiceRepository, @sales_engine.invoices
  end

  def test_sales_engine_invoice_item_is_invoice_item_repo
    assert_instance_of InvoiceItemRepository, @sales_engine.invoice_items
  end

  def test_sales_engine_items_is_item_repo
    assert_instance_of ItemRepository, @sales_engine.items
  end

  def test_sales_engine_merchants_is_merchant_repo
    assert_instance_of MerchantRepository, @sales_engine.merchants
  end

  def test_sales_engine_transaction_is_transactions_repo
    assert_instance_of TransactionRepository, @sales_engine.transactions
  end

  def test_sales_analyst_is_self_referential_analyst
    assert_instance_of SalesAnalyst, @sales_engine.analyst
  end
end
