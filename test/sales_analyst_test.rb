require_relative './test_helper'
require_relative '../lib/item'
require_relative '../lib/item_repository'
require_relative '../lib/merchant'
require_relative '../lib/merchant_repository'
require_relative '../lib/invoice'
require_relative '../lib/invoice_repository'
require_relative '../lib/invoice_item'
require_relative '../lib/invoice_item_repository'
require_relative '../lib/transaction'
require_relative '../lib/transaction_repository'
require_relative '../lib/customer'
require_relative '../lib/customer_repository'
require_relative '../lib/sales_engine'
require_relative '../lib/sales_analyst'

class SalesAnalystTest < Minitest::Test

  def setup
    @sales_engine = SalesEngine.from_csv({
        :items => './data/items.csv',
        :merchants => './data/merchants.csv',
        :invoices => './data/invoices.csv',
        :invoice_items => './data/invoice_items.csv',
        :transactions => './data/transactions.csv',
        :customers => './data/customers.csv'
    })
    @sales_analyst = @sales_engine.analyst
  end

  def test_it_exists
    assert_instance_of SalesAnalyst, @sales_analyst
  end

  def test_it_can_calculate_average_items_per_merchant
    assert_equal 2.88, @sales_analyst.average_items_per_merchant
  end

  def test_it_can_calculate_standard_deviation
    set = [3, 4, 5]

    assert_equal 1, @sales_analyst.standard_deviation(set)
  end

  def test_it_can_calculate_standard_deviation_of_average
    assert_equal 3.26, @sales_analyst.average_items_per_merchant_standard_deviation
  end

  def test_it_can_return_merchants_with_high_item_count
    actual = @sales_analyst.merchants_with_high_item_count.count
    assert_equal 52, actual
  end

  def test_it_can_return_average_item_price_per_merchant
    actual = @sales_analyst.average_item_price_for_merchant(12334105)
    assert_equal 16.66, actual
  end

  def test_it_can_average_the_average_price_per_merchant
    actual = @sales_analyst.average_average_price_per_merchant
    assert_equal 350.29, actual
  end

  def test_it_can_return_golden_items
    actual = @sales_analyst.golden_items.count
    assert_equal 5, actual
  end

  def test_can_calc_average_invoices_per_merchant
    assert_equal 10.49, @sales_analyst. average_invoices_per_merchant
  end

  def test_can_calc_std_dev_average_invoices_per_merchant
    assert_equal 3.29, @sales_analyst. average_invoices_per_merchant_standard_deviation
  end

  def test_it_can_return_high_invoice_performance_merchants
    assert_equal 12, @sales_analyst.top_merchants_by_invoice_count.length
  end

  def test_it_can_return_bottom_invoice_performance_merchants
    assert_equal 4, @sales_analyst.bottom_merchants_by_invoice_count.length
  end

  def test_it_returns_top_days_by_invoice_count
    assert_equal 1, @sales_analyst.top_days_by_invoice_count.length
  end

  def test_can_return_percentages_for_each_status
    assert_equal 29.55, @sales_analyst.invoice_status(:pending)
    assert_equal 56.95, @sales_analyst.invoice_status(:shipped)
    assert_equal 13.5, @sales_analyst.invoice_status(:returned)
  end

  def test_can_check_if_invoice_is_paid_in_full
    assert @sales_analyst.invoice_paid_in_full?(1)
    assert @sales_analyst.invoice_paid_in_full?(200)
    refute @sales_analyst.invoice_paid_in_full?(203)
    refute @sales_analyst.invoice_paid_in_full?(204)
  end

  def test_can_calc_invoice_total_dollar_amount
    assert_equal 21067.77, @sales_analyst.invoice_total(1)
  end

  def test_it_can_calculate_top_merchant_for_customer_id
    assert_equal 12336753, @sales_analyst.top_merchant_for_customer(100).id
    #11,100,12336753,pending,2006-04-05,2007-05-28
  end

  def test_can_return_top_buyers
    actual1 = @sales_analyst.top_buyers(5)
    assert_equal 5, actual1.length
    assert_equal 313, actual1.first.id
    assert_equal 478, actual1.last.id

    actual2 = @sales_analyst.top_buyers
    assert_equal 20, actual2.length
    assert_equal 313, actual2.first.id
    assert_equal 250, actual2.last.id
  end

  def test_can_return_list_one_time_buyers
    actual = @sales_analyst.one_time_buyers
    first_id = actual.first.id

    assert_equal 76, actual.length
    assert_equal 1, @sales_engine.invoices.find_all_by_customer_id(first_id).length
  end

  def test_find_item
    item = @sales_analyst.one_time_buyers_top_item
    assert_equal 263396463, item.id
  end

end
