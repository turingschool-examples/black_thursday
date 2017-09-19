require_relative 'test_helper'
require './lib/sales_analyst'

class MerchantAnalystTest < Minitest::Test

  def setup
    item_file_path = './test/fixtures/items_truncated.csv'
    merchant_file_path = './test/fixtures/merchants_truncated.csv'
    invoice_file_path = './test/fixtures/invoices_truncated.csv'
    invoice_item_file_path = './test/fixtures/invoice_items_truncated.csv'
    customer_file_path = './test/fixtures/customers_truncated.csv'
    transaction_file_path = './test/fixtures/transactions_truncated.csv'
    @engine = SalesEngine.new(item_file_path, merchant_file_path, invoice_file_path, invoice_item_file_path, customer_file_path, transaction_file_path)
    @analyst = SalesAnalyst.new(@engine)
  end

  def test_total_revenue_by_date_returns_total_amount
    revenue = @analyst.total_revenue_by_date('2003-05-16')

    assert_equal 15620.53, revenue
  end

  def test_revenue_per_merchant_returns_hash_with_merchant_id_key_and_revenue_value
    assert_equal 15620.53, @analyst.revenue_per_merchant(12334185)
  end

  def test_total_revenue_for_all_merchants_returns_hash_with_merchant_id_key_and_revenue_value
    assert_equal ({12334185=>0.1562053e5, 12334113=>0, 12334112=>0, 12334115=>0.2253302e5}), @analyst.total_revenue_for_all_merchants
  end

  def test_top_revenue_earners_returns_x_number_of_top_earning_merchants
    high_earners = @analyst.top_revenue_earners(3)

    assert_equal 3, high_earners.count
    assert_instance_of Merchant, high_earners[0]
    assert_equal 12334112, high_earners[0].id
    assert_equal 12334185, high_earners[1].id
    assert_equal 12334115, high_earners[-1].id
  end
end
