require_relative 'test_helper'
require_relative '../lib/sales_engine'

class SalesEngineTest < Minitest::Test
  def setup
    @information = {
      items: './test/fixtures/items_list_truncated.csv',
      merchants: './test/fixtures/merchants_list_truncated.csv',
      invoices: './test/fixtures/invoices_list_truncated.csv',
      invoice_items: './test/fixtures/invoice_items_list_truncated.csv',
      transactions: './test/fixtures/transactions_list_truncated.csv',
      customers: './test/fixtures/customer_list_truncated.csv'
    }
    @sales_engine = SalesEngine.new(@information)
  end

  def test_it_exists
    assert_instance_of SalesEngine, @sales_engine
  end

  def test_for_from_csv_method
    actual_item_path = SalesEngine.from_csv(@information).item_csv_path
    actual_merchant_path = SalesEngine.from_csv(@information).merchant_csv_path
    actual_invoice_path = SalesEngine.from_csv(@information).invoice_csv_path

    assert_equal @information[:items], actual_item_path
    assert_equal @information[:merchants], actual_merchant_path
    assert_equal @information[:invoices], actual_invoice_path
  end

  def test_for_items_method
    ir = @sales_engine.items

    assert ir.is_a?(ItemRepository)
  end

  def test_for_merchants_method
    mr = @sales_engine.merchants

    assert mr.is_a?(MerchantRepository)
  end
end
