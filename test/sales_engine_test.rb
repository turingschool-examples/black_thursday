require './test/test_helper'
require './lib/sales_engine'

class SalesEngineTest < Minitest::Test
  include SalesEngineTestSetup

  def setup
    super
  end

  def test_sales_engine_exists
    assert_instance_of SalesEngine, @se
  end

  def test_se_merchant_method_reads_merchant_file
    assert_instance_of MerchantRepository, @se.merchants
  end

  def test_se_item_method_reads_items_file
    assert_instance_of ItemRepository, @se.items
  end

  def test_se_invoice_method_reads_items_file
    assert_instance_of InvoiceRepository, @se.invoices
  end

  def test_se_invoice_items_method_reads_items_file
    assert_instance_of InvoiceItemRepository, @se.invoice_items
  end

  def test_se_transactions_method_reads_items_file
    assert_instance_of TransactionRepository, @se.transactions
  end

  def test_se_customers_method_reads_items_file
    assert_instance_of CustomerRepository, @se.customers
  end
end
