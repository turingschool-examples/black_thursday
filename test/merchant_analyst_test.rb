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

  def test_top_revenue_earners_returns_x_number_of_top_earning_merchants
    high_earners = @analyst.top_revenue_earners(3)
    p high_earners
end
