require_relative 'test_helper'
require_relative '../lib/sales_engine'

class SalesEngineTest < Minitest::Test
  def setup
    @se = SalesEngine.from_csv({
      items:     './test/fixtures/items_truncated.csv',
      merchants: './test/fixtures/merchants_truncated.csv',
      invoices: './test/fixtures/invoices_truncated.csv',
      invoice_items: './test/fixtures/invoice_items_truncated.csv',
      transactions: './test/fixtures/transactions_truncated.csv',
      customers: './test/fixtures/customers_truncated.csv'
    })
  end

  def test_it_creates_instance_of_item_repository
    assert_instance_of ItemRepository, @se.items
  end

  def test_it_creates_instance_of_merchant_repository
    assert_instance_of MerchantRepository, @se.merchants
  end

  def test_it_creates_instance_of_invoice_repository
    assert_instance_of InvoiceRepository, @se.invoices
  end

  def test_it_calls_item_repository_to_return_items_by_merchant_id
    result = @se.find_items_by_merchant_id(12334113)

    all_merchant_items = result.all? do |item|
      item.merchant_id == 12334113
    end

    assert all_merchant_items
  end

  def test_it_calls_merchant_repository_to_return_merchant_by_merchant_id
    merchant_id = 12334113

    result = @se.find_merchant_by_merchant_id(merchant_id)

    assert result.id, merchant_id
    assert_instance_of Merchant, result
  end

  def test_find_invoices_by_merchant_id_returns_invoices_with_matching_id
    merchant = @se.merchants.find_by_id(12334105)
    invoices = merchant.invoices

    assert_equal 2, invoices.count
    assert invoices.all? do |invoice|
      invoice.merchant_id == 12335938
    end
  end

  def test_it_finds_merchant_by_invoice_id_returns_merchant_with_matching_id
    invoice = @se.invoices.find_by_id(12)
    merchant = invoice.merchant
    merchant_id = 12334149

    assert_instance_of Merchant, merchant
    assert_equal merchant_id, invoice.merchant_id
    assert_equal merchant_id, merchant.id
  end

  def test_it_finds_item_by_item_id
    item = @se.find_item_by_item_id(263395617)

    assert_instance_of Item, item
    assert_equal 263395617, item.id
  end
end
