require 'simplecov'
SimpleCov.start
require 'minitest/pride'
require 'minitest/autorun'
require_relative '../lib/item'
require_relative '../lib/item_repository'
require_relative '../lib/merchant'
require_relative '../lib/merchant_repository'
require_relative '../lib/sales_analyst'
require_relative '../lib/invoice_item_repository'
require_relative '../lib/transaction_repository'
require_relative '../lib/transaction'
require_relative '../lib/customer_repository'
require_relative '../lib/customer'
require_relative '../lib/invoice'
require_relative '../lib/invoice_repository'
require_relative '../lib/sales_engine'
require_relative '../lib/math_helper'
require_relative '../lib/sales_analyst'
require_relative '../lib/sales_engine'

class SalesAnalystTest < Minitest::Test

  def setup
    @sales_engine = SalesEngine.new
    @sales_engine.merchant_repository = @sales_engine.merchant_builder('./test/fixtures/merchants.csv')
    @sales_engine.item_repository = @sales_engine.item_builder('./test/fixtures/items.csv')
    @sales_engine.invoice_item_repository = @sales_engine.invoice_item_builder('./test/fixtures/invoice_items.csv')
    @sales_engine.transaction_repository = @sales_engine.transaction_builder('./test/fixtures/transactions.csv')
    @sales_engine.customer_repository = @sales_engine.customer_builder('./test/fixtures/customers.csv')
    @sales_engine.invoice_repository = @sales_engine.invoice_builder('./test/fixtures/invoices.csv')
    @sales_analyst = @sales_engine.analyst
  end


  def test_it_exists
    merchant_repository = []
    item_repository = []
    invoice_item_repository = []
    transaction_repository = []
    invoice_repository = []
    sa = SalesAnalyst.new(merchant_repository,
                          item_repository,
                          invoice_item_repository,
                          transaction_repository,
                          invoice_repository)

    assert_instance_of SalesAnalyst, sa
  end

  def test_we_can_initialize_by_sales_engine
    se = SalesEngine.new
    sa = se.analyst
    assert_instance_of SalesAnalyst, sa
  end

  def test_it_contains_repositories
    assert_instance_of MerchantRepository, @sales_analyst.merchant_repository
    assert_instance_of ItemRepository, @sales_analyst.item_repository
    assert_instance_of InvoiceRepository, @sales_analyst.invoice_repository
    assert_instance_of TransactionRepository, @sales_analyst.transaction_repository
    assert_instance_of InvoiceItemRepository, @sales_analyst.invoice_item_repository
  end

  def test_we_can_get_the_average_items_per_merchant
    expected = 3.0
    result = @sales_analyst.average_items_per_merchant
    assert_equal expected, result
  end

  def test_we_can_get_the_average_price_for_merchant
    expected = 16.66
    result = @sales_analyst.average_item_price_for_merchant(12334105)
    assert_equal expected, result
  end

  def test_we_can_get_the_average_average_price_per_merchant
    expected = 14.89
    result = @sales_analyst.average_average_price_per_merchant
    assert_equal expected, result.to_f
  end

  def test_we_can_see_if_an_invoice_was_paid_in_full
    expected = true
    result = @sales_analyst.invoice_paid_in_full?(1)
    assert_equal expected, result
  end

  def test_we_can_get_average_invoices_per_merchant
    expected = 2.5
    result = @sales_analyst.average_invoices_per_merchant
    assert_equal expected, result
  end

  def test_we_can_get_average_invoices_per_merchant_stdev
    expected = 2.06
    result = @sales_analyst.average_invoices_per_merchant_standard_deviation
    assert_equal expected, result
  end

  def test_we_can_get_average_invoices_per_day_stdev
    expected = 0.49
    result = @sales_analyst.average_invoices_per_day_standard_deviation
    assert_equal expected, result
  end

  def test_we_can_get_the_top_revenue_earners
    merchant_1 = @sales_analyst.merchant_repository.all[0]
    merchant_2 = @sales_analyst.merchant_repository.all[1]
    expected = [merchant_1, merchant_2]
    result = @sales_analyst.top_revenue_earners(2)
    assert_equal expected, result
  end

  def test_we_can_find_merchants_with_pending_invoices
    merchant_1 = @sales_analyst.merchant_repository.all[2]
    expected = [merchant_1]
    result = @sales_analyst.merchants_with_pending_invoices
    assert_equal expected, [result[0]]
  end

  def test_we_can_get_merchants_with_only_one_item
    skip
    merchant = @sales_analyst.merchant_repository.all[5]
    expected = [merchant]
    result = @sales_analyst.merchants_with_only_one_item
    assert_equal expected, result
  end

  def test_we_can_get_merchant_ids
    expected = [12334105, 12334112, 12334113, 12334115, 12334123, 99999999]
    result = @sales_analyst.get_merchant_ids
    assert_equal expected, result
  end

end
