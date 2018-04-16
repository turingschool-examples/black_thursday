require_relative 'test_helper'
require_relative '../lib/sales_engine'

# Test class SalesEngine
class SalesEngineTest < Minitest::Test
  def setup
    @se = SalesEngine.from_csv(
                              items:      './data/items.csv',
                              merchants:  './test/fixtures/merchants_fixtures.csv',
                              invoices:   './test/fixtures/invoices_fixtures.csv',
                              invoice_items:   './test/fixtures/invoice_items_fixtures.csv',
                              transactions:   './test/fixtures/transactions_fixtures.csv'
                              )
  end

  def test_it_returns_repositories
    assert_instance_of ItemRepository, @se.items
    assert_instance_of MerchantRepository, @se.merchants
    assert_instance_of InvoiceRepository, @se.invoices
    assert_instance_of InvoiceItemRepository, @se.invoice_items
    assert_instance_of TransactionRepository, @se.transactions
    assert_instance_of SalesEngine, @se
    assert_instance_of CustomerRepository, @se.customers
  end

  def test_it_returns_a_sales_analyst
    sa = @se.analyst
    assert_instance_of SalesAnalyst, sa
  end
end
