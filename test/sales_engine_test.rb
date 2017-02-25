require './test/test_helper'
require './lib/sales_engine'

class SalesEngineTest < Minitest::Test
  def test_does_it_exist
    files_to_be_loaded = {
      :merchants => "./data/merchants.csv",
      :items     => "./data/items.csv",
      :customers => "./data/customers.csv",
      :invoices  => "./data/invoices.csv",
      :invoice_items => "./data/invoice_items.csv",
      :transactions  => "./data/transactions.csv"
      }
    se = SalesEngine.new(files_to_be_loaded)
    assert_instance_of SalesEngine, se
  end

  def test_has_method_that_takes_hash_of_things_and_returns_a_sales_engine
    se = SalesEngine.from_csv({
      :merchants => "./data/merchants.csv",
      :items     => "./data/items.csv",
      :customers => "./data/customers.csv",
      :invoices  => "./data/invoices.csv",
      :invoice_items => "./data/invoice_items.csv",
      :transactions  => "./data/transactions.csv"
      })
    assert_instance_of SalesEngine, se
  end

  def test_data_files_return_instance_of_corresponding_repositories
    se = SalesEngine.from_csv({
      :merchants => "./data/merchants.csv",
      :items     => "./data/items.csv",
      :customers => "./data/customers.csv",
      :invoices  => "./data/invoices.csv",
      :invoice_items => "./data/invoice_items.csv",
      :transactions  => "./data/transactions.csv"
      })
    assert_instance_of MerchantRepository, se.merchants
    assert_instance_of ItemRepository, se.items
    assert_instance_of CustomerRepository, se.customers
    assert_instance_of InvoiceRepository, se.invoices
    assert_instance_of InvoiceItemRepository, se.invoice_items
    assert_instance_of TransactionRepository, se.transactions
  end

  def test_items_returns_an_Item_Repository
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :customers => "./data/customers.csv"
      })

    assert_instance_of ItemRepository, se.items
  end

  def test_customers_returns_a_Customers_repository
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :customers => "./data/customers.csv"
      })

    assert_instance_of CustomerRepository, se.customers
  end
end
