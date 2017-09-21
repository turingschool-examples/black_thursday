require_relative 'test_helper'
require './lib/sales_engine'

class MerchantTest < Minitest::Test

  def setup
    item_file_path = './test/fixtures/items_truncated.csv'
    merchant_file_path = './test/fixtures/merchants_truncated.csv'
    invoice_file_path = './test/fixtures/invoices_truncated.csv'
    invoice_item_file_path = './test/fixtures/invoice_items_truncated.csv'
    customer_file_path = './test/fixtures/customers_truncated.csv'
    transaction_file_path = './test/fixtures/transactions_truncated.csv'
    engine = SalesEngine.new(item_file_path, merchant_file_path,
    invoice_file_path, invoice_item_file_path, customer_file_path,
    transaction_file_path)
    merchant_repo = engine.merchants
    @merchants = merchant_repo.merchants
  end

  def test_class_merchant_exists
    merchant = @merchants[0]

    assert_instance_of Merchant, merchant
  end

  def test_it_initializes_with_id_and_name_and_sales_engine
    merchant = @merchants[0]

    assert_equal 12334112, merchant.id
    assert_equal "Candisart", merchant.name
    assert_instance_of SalesEngine, merchant.engine
  end

  def test_items_returns_all_merchant_id_items_in_one_array
    merchant = @merchants[-1]

    assert_equal 3, merchant.items.count
  end

  def test_it_can_find_all_invoices_associated_with_merchant
    merchant = @merchants[-1]

    assert_equal 10, merchant.invoices.count
  end

  def test_it_can_find_customers_associated_with_merchant
    merchant = @merchants[-1]
    merchant_customers = merchant.customers

    assert_equal 10, merchant_customers.count
    assert_instance_of Customer, merchant_customers[0]
    assert_equal 297, merchant_customers[0].id
  end

  def test_it_finds_pending_invoices_for_merchant
    merchant = @merchants[0]

    assert_equal 0, merchant.invoices_paid_in_full.count

    merchant = @merchants[-1]

    assert_equal 6, merchant.invoices_paid_in_full.count
  end
end
