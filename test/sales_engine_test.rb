require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require 'minitest/pride'
require './lib/sales_engine'

class SalesEngineTest < Minitest::Test
  attr_reader   :sales_engine

  def setup
    @sales_engine = SalesEngine.from_csv({
    :items => "./fixture/items.csv",
    :merchants => "./fixture/merchant_test_file.csv",
    :invoices => "./fixture/invoices.csv",
    # :invoice_items => "./fixture/invoice_items.csv",
    # :customers => "./fixture/customers.csv",
    # :transactions => "./fixture/transactions.csv"
    })
  end

  def test_it_can_create_sales_engine
    assert sales_engine
  end

  def test_it_has_instance_of_item_repo
    assert sales_engine.items
    assert_instance_of ItemRepository, sales_engine.items
  end

  def test_it_has_instance_of_merchant_repo
    assert sales_engine.merchants
    assert_instance_of MerchantRepository, sales_engine.merchants
  end

  def test_it_has_instance_of_invoice_repo
    assert sales_engine.invoices
    assert_instance_of InvoiceRepository, sales_engine.invoices
  end

  def test_it_has_instance_of_invoice_item_repo
    skip
    assert sales_engine.invoice_items
    assert_instance_of InvoiceItemRepository, sales_engine.invoice_items
  end

  def test_it_has_instance_of_customer_repo
    skip
    assert sales_engine.customers
    assert_instance_of CustomerRepository, sales_engine.customers
  end

  def test_it_has_instance_of_transaction_repo
    skip
    assert sales_engine.transactions
    assert_instance_of TransactionRepository, sales_engine.transactions
  end

end