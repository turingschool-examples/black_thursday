require './test/test_helper'
require './lib/sales_engine'

class SalesEngineTest < Minitest::Test

  def setup
    @se = SalesEngine.from_csv({
      :merchants => "./test/fixtures/merchants_truncated.csv",
      :items     => "./test/fixtures/items_truncated.csv",
      :invoices  => "./test/fixtures/invoices_truncated.csv",
      :invoice_items => "./test/fixtures/invoice_items_truncated.csv",
      :transactions  => "./test/fixtures/transactions_truncated.csv",
      :customers => "./test/fixtures/customers_truncated.csv"
      })
  end

  def test_it_exists
    assert_instance_of SalesEngine, @se
  end

  def test_has_method_that_takes_hash_of_things_and_returns_a_sales_engine
    assert_instance_of SalesEngine, @se
  end

  def test_data_files_return_instance_of_corresponding_repositories
    assert_instance_of MerchantRepository, @se.merchants
    assert_instance_of ItemRepository, @se.items
    assert_instance_of InvoiceRepository, @se.invoices
    assert_instance_of InvoiceItemRepository, @se.invoice_items
    assert_instance_of TransactionRepository, @se.transactions
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

    assert_instance_of Merchant, merchant_item
  end

  def test_it_can_find_all_merchant_invoices
    merchant = @se.merchants.find_by_id(12334115)
    invoices = merchant.invoices

    assert_instance_of Array, invoices
    assert_instance_of Invoice, invoices.first
    assert_equal 11, invoices.count
  end

  def test_it_can_find_merchant_of_invoice
    invoice = @se.invoices.find_by_id(74)

    assert_instance_of Merchant, invoice.merchant
    assert_equal 12334105, invoice.merchant.id
  end

  def test_it_can_find_array_of_merchants_from_item
    invoice = @se.invoices.find_by_id(74)

    assert_instance_of Array, invoice.items
  end

  def test_it_can_find_transactions_of_invoice
    invoice = @se.invoices.find_by_id(74)

    assert_instance_of Array, invoice.transactions
  end

  def test_it_can_find_customer_by_invoice
    invoice = @se.invoices.find_by_id(74)

    assert_instance_of Customer, invoice.customer
  end
end
