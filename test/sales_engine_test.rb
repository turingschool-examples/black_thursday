#require 'simplecov'
#SimpleCov.start

require 'minitest/pride'
require 'minitest/autorun'
require_relative '../lib/item'
require_relative '../lib/item_repository'
require_relative '../lib/merchant'
require_relative '../lib/merchant_repository'
require_relative '../lib/sales_analyst'
require_relative '../lib/invoice_item_repository'
require_relative '../lib/transaction_repository'
require_relative '../lib/transaction'
require_relative '../lib/customer_repository'
require_relative '../lib/customer'
require_relative '../lib/invoice'
require_relative '../lib/invoice_repository'
require_relative '../lib/sales_engine'
require_relative '../lib/math_helper'

class SalesEngineTest < Minitest::Test

# We are effectively testing that our item builders are functional in the setup method
# so is testing the builders individually necessary?
  def setup
    @sales_engine = SalesEngine.new
    @sales_engine.merchant_repository = @sales_engine.merchant_builder('./test/fixtures/merchants.csv')
    @sales_engine.item_repository = @sales_engine.item_builder('./test/fixtures/items.csv')
    @sales_engine.invoice_item_repository = @sales_engine.invoice_item_builder('./test/fixtures/invoice_items.csv')
    @sales_engine.transaction_repository = @sales_engine.transaction_builder('./test/fixtures/transactions.csv')
    @sales_engine.customer_repository = @sales_engine.customer_builder('./test/fixtures/customers.csv')
    @sales_engine.invoice_repository = @sales_engine.invoice_builder('./test/fixtures/invoices.csv')
  end

  def test_it_exists
    assert_instance_of SalesEngine, @sales_engine
  end

  def test_it_can_return_a_merchant_repository
    assert_instance_of MerchantRepository, @sales_engine.merchant_repository
  end

  def test_it_can_return_an_item_repository
    assert_instance_of ItemRepository, @sales_engine.item_repository
  end

  def test_it_can_return_an_invoice_item_repository
    assert_instance_of InvoiceItemRepository, @sales_engine.invoice_item_repository
  end

  def test_it_can_return_a_transaction_repository
    assert_instance_of TransactionRepository, @sales_engine.transaction_repository
  end

  def test_it_can_return_a_customer_repository
    assert_instance_of CustomerRepository, @sales_engine.customer_repository
  end

  def test_it_can_return_an_invoice_repository
    assert_instance_of InvoiceRepository, @sales_engine.invoice_repository
  end

end
