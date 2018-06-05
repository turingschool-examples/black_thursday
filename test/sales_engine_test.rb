require './test/test_helper.rb'
require './lib/sales_engine.rb'
require 'pry'

class SalesEngineTest < Minitest::Test
  def test_it_exists
    se = SalesEngine.from_csv('content')
    assert_instance_of SalesEngine, se
  end

  def test_it_has_from_csv
    se = SalesEngine.from_csv(
      items: './data/items.csv',
      merchants: './data/merchants.csv'
    )
    assert_equal ({
      items: './data/items.csv',
      merchants: './data/merchants.csv'
    }), se.content
  end

  def test_merchants_creates_array_of_merchants
    se = SalesEngine.from_csv(
      items: './data/items.csv',
      merchants: './data/merchants.csv'
    )
    assert_equal 475, se.merchants.repository.count
  end

  def test_items_creates_repository_of_items
    se = SalesEngine.from_csv(
      items: './data/items.csv',
      merchants: './data/merchants.csv'
    )
    assert_instance_of ItemRepository, se.items
  end

  def test_it_can_create_an_analyst
    se = SalesEngine.from_csv(
      items: './data/items.csv',
      merchants: './data/merchants.csv',
      invoices: './data/invoices_test.csv',
      customers: './data/customers.csv',
      invoice_items: './data/invoice_items_test.csv',
      transactions: './data/transactions_test.csv'
    )
    assert_instance_of SalesAnalyst, se.analyst
  end

  def test_invoices_creates_repository_of_invoices
    se = SalesEngine.from_csv(invoices: './data/invoices_test.csv')
    assert_instance_of InvoiceRepository, se.invoices
  end

  def test_invoices_creates_repository_of_invoice_items
    se = SalesEngine.from_csv(invoice_items: './data/invoice_items_test.csv')
    assert_instance_of InvoiceItemRepository, se.invoice_items
  end

  def test_invoices_creates_repository_of_transactions
    se = SalesEngine.from_csv(transactions: './data/transactions_test.csv')
    assert_instance_of TransactionRepository, se.transactions
  end
end
