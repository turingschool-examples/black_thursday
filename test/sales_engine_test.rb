require 'minitest/autorun'
require 'minitest/emoji'
require 'csv'
require 'bigdecimal'
require_relative '../lib/sales_engine'


class SalesEngineTest < Minitest::Test
  attr_reader :sales_engine

  def setup
    @sales_engine = SalesEngine.from_csv({
      :items          => "./data/items.csv",
      :merchants      => "./data/merchants.csv",
      :invoices       => "./data/invoices.csv",
      :customers      => "./data/customers.csv",
      :transactions   => "./data/transactions.csv",
      :invoice_items  => "./data/invoice_items.csv"})
  end

  def test_it_exists
    assert_equal Class, sales_engine.class
  end

  def test_it_can_instantiate_merchant_repo   
    assert_equal MerchantRepo, sales_engine.merchants.class
  end

  def test_it_can_instantiate_item_repo   
    assert_equal ItemRepo, sales_engine.items.class
  end
  
  def test_it_can_instantiate_invoice_repo  
    assert_equal InvoiceRepo, sales_engine.invoices.class
  end

  def test_it_can_instantiate_customer_repo   
    assert_equal CustomerRepo, sales_engine.customers.class
  end
  
  def test_it_can_instantiate_transaction_repo  
    assert_equal TransactionRepo, sales_engine.transactions.class
  end
  
  def test_it_can_instantiate_invoice_item_repo   
    assert_equal InvoiceItemRepo, sales_engine.invoice_items.class
  end
  
end