require './test/test_helper'

class SalesEngineTest < Minitest::Test

  attr_reader :se

  def setup
    @se = SalesEngine.from_csv({
      :merchants    => "./data/merchants.csv",
      :items        => "./data/items.csv",
      :invoices     => "./data/invoices.csv",
      :invoice_items => "./data/invoice_items.csv",
      :transactions => "./data/transactions.csv",
      :customers    => "./data/customers.csv"
      })
  end

  def test_it_exists
    assert_kind_of SalesEngine, SalesEngine.new
  end

  def test_from_csv_returns_sales_engine
    assert_kind_of SalesEngine, se
  end

  def test_merchant_variables_are_populated
    assert_instance_of MerchantRepository, se.merchants
  end

  def test_items_variables_are_populated
   assert_instance_of ItemRepository, se.items
  end

  def test_invoices_are_populated
    assert_instance_of InvoiceRepository, se.invoices
  end

  def test_invoice_items_variables_are_populated
    assert_instance_of InvoiceItemRepository, se.invoice_items
  end


  def test_items_transactions_are_populated
   assert_instance_of TransactionRepository, se.transactions
  end

  def test_items_customers_are_populated
   assert_instance_of CustomerRepository, se.customers
  end
end
