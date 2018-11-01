require './test/test_helper'

class SalesEngineTest < Minitest::Test

  def setup
    @se = SalesEngine.from_csv({items: './data/item_test.csv',
                                merchants: './data/merchant_test.csv', 
                                invoices: './data/invoices.csv',
                                transactions: './data/transactions.csv',
                                customers: './data/customers.csv',
                                invoice_items: './data/invoice_items.csv'})
  end

  def test_it_exists
    assert_instance_of SalesEngine, @se
  end

  def test_it_can_make_merchant_repo_instance
    assert_instance_of MerchantRepository, @se.merchants
  end

  def test_it_can_make_item_repo_instance
    assert_instance_of ItemRepository, @se.items
  end
  
  def test_it_can_make_invoice_repo_instance
    assert_instance_of InvoiceRepository, @se.invoices
  end
  
  def test_it_can_make_transaction_repo_instance
    assert_instance_of TransactionRepository, @se.transactions
  end
  
  def test_it_can_make_customer_repo_instance
    assert_instance_of CustomerRepository, @se.customers
  end
  
  def test_it_can_make_invoice_item_repo_instance
    assert_instance_of InvoiceItemRepository, @se.invoice_items
  end

  def test_that_merchant_repo_contains_merchants
    refute_equal 0, @se.merchants.all.size
    assert_instance_of Merchant, @se.merchants.all.first
  end

  def test_that_item_repo_contains_items
    refute_equal 1, @se.items.all
    assert_instance_of Item, @se.items.all.first
  end
  
  def test_that_invoice_repo_contains_invoices
    refute_equal 0, @se.invoices.all.size
    assert_instance_of Invoice, @se.invoices.all.first
  end
  
  def test_that_transaction_repo_contains_transactions
    refute_equal 0, @se.transactions.all.size
    assert_instance_of Transaction, @se.transactions.all.first
  end
  
  def test_that_invoice_item_repo_contains_invoice_items
    refute_equal 0, @se.invoice_items.all.size
    assert_instance_of InvoiceItem, @se.invoice_items.all.first
  end

  def test_that_customer_repo_contains_customers
    refute_equal 0, @se.customers.all.size
    assert_instance_of Customer, @se.customers.all.first
  end
end
