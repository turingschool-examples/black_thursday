require_relative 'test_helper'
require './lib/sales_analyst'

class MerchantAnalystTest < Minitest::Test

  def setup
    item_file_path = './test/fixtures/merchant_analyst_item_sample.csv'
    merchant_file_path = './test/fixtures/merchant_analyst_merchant_sample.csv'
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

  def test_revenue_by_merchant_returns_total_revenue_value_for_merchant
    assert_equal 15620.53, @analyst.revenue_by_merchant(12334185)
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

  def test_it_can_find_merchants_with_pending_invoices
    pending_merchants = @analyst.merchants_with_pending_invoices

    assert_equal 12334185, pending_merchants[0].id
    assert_instance_of Merchant, pending_merchants[0]
    assert_equal 1, pending_merchants.count
  end

  def test_it_finds_merchants_with_only_one_item
    one_item_merchants = @analyst.merchants_with_only_one_item

    assert_equal 12334969, one_item_merchants[0].id
    assert_equal 12334727, one_item_merchants[-1].id
    assert_instance_of Merchant, one_item_merchants[0]
    assert_equal 2, one_item_merchants.count
  end

  def test_it_finds_merchants_with_only_one_item_registered_in_month
    month_merchant =  @analyst.merchants_with_only_one_item_registered_in_month("June")

    assert_equal 12334969, month_merchant[0].id
    assert_instance_of Merchant, month_merchant[0]
    assert_equal 1, month_merchant.count
  end

  def test_it_finds_most_sold_item_for_merchant
    most_sold = @analyst.most_sold_item_for_merchant(12334185)

    assert_equal 263409041, most_sold[0].id
  end

  def test_it_can_find_best_item_for_merchant_by_highest_revenue
    best_item = @analyst.best_item_for_merchant(12334185)

    assert_equal 263409041, best_item.id
  end


end
