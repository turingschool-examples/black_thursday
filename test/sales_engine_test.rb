require_relative 'test_helper.rb'
require_relative '../lib/sales_engine'
require_relative 'sales_engine_methods'

class SalesEngineTest < Minitest::Test
  include SalesEngineMethods
  attr_reader :se

  def setup
    create_sales_engine
  end

  def test_it_exists
    assert_equal SalesEngine, se
  end

  def test_item_repo_instance_created
    assert_instance_of ItemRepository, se.items
  end

  def test_merchant_repo_instance_created
    assert_instance_of MerchantRepository, se.merchants
  end

  def test_invoice_repo_instance_created
    assert_instance_of InvoiceRepository, se.invoices
  end

  def test_invoice_items_repo_instance_created
    assert_instance_of InvoiceItemRepository, se.invoice_items
  end

  def test_transactions_repo_instance_created
    assert_instance_of TransactionRepository, se.transactions
  end

  def test_customers_repo_instance_created
    assert_instance_of CustomerRepository, se.customers
  end

end
