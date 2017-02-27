require './test/test_helper'
require './lib/sales_engine'

class SalesEngineTest < Minitest::Test

  def setup
    @se = SalesEngine.from_csv({
      :merchants => "./data/merchants.csv",
      :items     => "./data/items.csv",
      :customers => "./data/customers.csv",
      :invoices  => "./data/invoices.csv",
      :invoice_items => "./data/invoice_items.csv",
      :transactions  => "./data/transactions.csv"
      })
  end

  def test_does_it_exist
    assert_instance_of SalesEngine, @se
  end

  def test_has_method_that_takes_hash_of_things_and_returns_a_sales_engine
    assert_instance_of SalesEngine, @se
  end

  def test_data_files_return_instance_of_corresponding_repositories
    assert_instance_of MerchantRepository, @se.merchants
    assert_instance_of ItemRepository, @se.items
    assert_instance_of CustomerRepository, @se.customers
    assert_instance_of InvoiceRepository, @se.invoices
    # assert_instance_of InvoiceItemRepository, @se.invoice_items
    assert_instance_of TransactionRepository, @se.transactions
  end

  def test_items_returns_an_Item_Repository
    assert_instance_of ItemRepository, @se.items
  end

  def test_customers_returns_a_Customers_repository
    assert_instance_of CustomerRepository, @se.customers
  end

  def test_can_return_items_of_a_merchant
    merchant = @se.merchants.find_by_id(12334112)
    merchant_items = merchant.items

    assert_equal 1, merchant_items.count
    assert_instance_of Item, merchant_items.first
    assert_instance_of Array, merchant_items
  end

  def test_it_can_return_merchant_of_item
    item = @se.items.find_by_id(263395237)
    merchant_item = item.merchant

    # assert_equal
    assert_instance_of Merchant, merchant_item
  end
end
