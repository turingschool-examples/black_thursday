require_relative 'test_helper'
require_relative '../lib/merchant'
require_relative '../lib/sales_engine'

class MerchantTest < Minitest::Test
  def test_it_exists
    merchant = Merchant.new(id: 5, name: 'Turing School')

    assert_instance_of Merchant, merchant
  end

  def test_it_has_an_id
    merchant = Merchant.new(id: 5, name: 'Turing School')

    assert_equal 5, merchant.id
  end

  def test_finding_items_associated_with_merchant
    information = {
      items: './test/fixtures/items_list_truncated.csv',
      merchants: './test/fixtures/merchants_list_truncated.csv',
      invoices: './test/fixtures/invoices_list_truncated.csv',
      invoice_items: './test/fixtures/invoice_items_list_truncated.csv',
      transactions: './test/fixtures/transactions_list_truncated.csv',
      customers: './test/fixtures/customer_list_truncated.csv'
    }
    sales_engine = SalesEngine.from_csv(information)
    merchant = sales_engine.merchants.find_by_id(123_341_12)

    assert_instance_of Array, merchant.items
    assert_instance_of Item, merchant.items.first
    assert_equal 263_410_021, merchant.items.first.id
  end

  def test_finding_invoices_associated_with_merchant
    information = {
      items: './test/fixtures/items_list_truncated.csv',
      merchants: './test/fixtures/merchants_list_truncated.csv',
      invoices: './test/fixtures/invoices_list_truncated.csv',
      invoice_items: './test/fixtures/invoice_items_list_truncated.csv',
      transactions: './test/fixtures/transactions_list_truncated.csv',
      customers: './test/fixtures/customer_list_truncated.csv'
    }
    sales_engine = SalesEngine.from_csv(information)
    merchant = sales_engine.merchants.find_by_id(12_334_112)

    assert_instance_of Array, merchant.invoices
    assert_equal 2, merchant.invoices.length
    assert_instance_of Invoice, merchant.invoices.first
    assert_equal 269, merchant.invoices.first.id
  end

  def test_finding_customers_associated_with_merchant
    information = {
      items: './test/fixtures/items_list_truncated.csv',
      merchants: './test/fixtures/merchants_list_truncated.csv',
      invoices: './test/fixtures/invoices_list_truncated.csv',
      invoice_items: './test/fixtures/invoice_items_list_truncated.csv',
      transactions: './test/fixtures/transactions_list_truncated.csv',
      customers: './test/fixtures/customer_list_truncated.csv'
    }
    sales_engine = SalesEngine.from_csv(information)
    merchant = sales_engine.merchants.find_by_id(123_341_12)

    assert_instance_of Array, merchant.customers
    assert_instance_of Customer, merchant.customers.first
    assert_equal 51, merchant.customers.first.id
    assert_equal 2, merchant.customers.length
  end
end
