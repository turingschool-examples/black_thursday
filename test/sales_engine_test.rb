require_relative 'test_helper'
require_relative '../lib/sales_engine'

class SalesEngineTest < Minitest::Test

  attr_reader :se

  def setup
    @se = SalesEngine.from_csv({
            :items => './test/fixtures/items_truncated_3.csv',
            :merchants => './test/fixtures/merchants_truncated_11.csv',
            :invoices => './test/fixtures/invoices_truncated_56.csv',
            :invoice_items => './test/fixtures/invoice_items_truncated_10.csv',
            :transactions => './test/fixtures/transaction_truncated_10.csv',
            :customers => './test/fixtures/customers_truncated_10.csv'
    })
  end

  def test_from_csv_created_an_instance_of_sales_engine
    assert_instance_of SalesEngine, se
  end

  def test_from_csv_created_different_repositories_assigned_to_appropriate_instance_variables
    assert_instance_of MerchantRepository, se.merchants
    assert_instance_of ItemRepository, se.items
    assert_instance_of InvoiceItemRepository, se.invoice_items
    assert_instance_of CustomerRepository, se.customers
  end

  def test_items_called_on_merchant_returns_array_of_item_objects_associated_with_merchant
    merchant = se.merchants.find_by_id(12334112)
    actual = merchant.items

    assert_instance_of Item, actual[0]
    assert_instance_of Item, actual[1]
    assert_equal 12334112, actual[0].merchant_id
    assert_equal 12334112, actual[1].merchant_id
    refute_equal actual[0], actual[1]
  end

  def test_merchant_called_on_item_returns_merchant_instance
    item = se.items.find_by_id(263395237)
    actual = item.merchant

    assert_instance_of Merchant, actual
    assert_equal item.merchant_id, actual.id
  end

  def test_invoices_called_on_merchant_returns_array_of_invoice_objects_associated_with_merchant
    merchant = se.merchants.find_by_id(12334112)
    actual = merchant.invoices

    assert_instance_of Invoice, actual[0]
    assert_instance_of Invoice, actual[-1]
    assert_equal 12334112, actual[0].merchant_id
    assert_equal 12334112, actual[-1].merchant_id
    refute_equal actual[0], actual[-1]
  end

  def test_merchant_called_on_invoice_returns_merchant_instance
    invoice = se.invoices.find_by_id(1)
    actual = invoice.merchant

    assert_instance_of Merchant, actual
    assert_equal invoice.merchant_id, actual.id
  end

  def test_items_called_on_invoice_returns_items_associated_with_that_invoice
    se = SalesEngine.from_csv({
            :items => './test/fixtures/items_truncated_10.csv',
            :merchants => './test/fixtures/merchants_truncated_11.csv',
            :invoices => './test/fixtures/invoices_truncated_56.csv',
            :invoice_items => './test/fixtures/invoice_items_truncated_10.csv',
            :transactions => './test/fixtures/transaction_truncated_10.csv',
            :customers => './test/fixtures/customers_truncated_10.csv'
    })
    invoice = se.invoices.find_by_id(1)
    actual = invoice.items

    actual.each do |item|
      assert_instance_of Item, item
    end
    assert_equal "510+ RealPush Icon Set", actual[0].name
    assert_equal "Glitter scrabble frames", actual[1].name
  end

  def test_transactions_called_on_invoice_returns_transactions_associated_with_that_invoice
    se = SalesEngine.from_csv({
            :items => './test/fixtures/items_truncated_10.csv',
            :merchants => './test/fixtures/merchants_truncated_11.csv',
            :invoices => './test/fixtures/invoices_truncated_56.csv',
            :invoice_items => './test/fixtures/invoice_items_truncated_10.csv',
            :transactions => './test/fixtures/transaction_truncated_10.csv',
            :customers => './test/fixtures/customers_truncated_10.csv'
    })
    invoice = se.invoices.find_by_id(1)
    actual = invoice.transactions

    actual.each do |transaction|
      assert_instance_of Transaction, transaction
    end
    assert_equal se.transactions.all.first, actual.first
  end

end
