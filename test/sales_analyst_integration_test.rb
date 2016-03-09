require 'pry'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/merchant'
require_relative '../lib/merchant_repository'
require_relative '../lib/item'
require_relative '../lib/item_repository'
require_relative '../lib/sales_engine'
require_relative '../lib/sales_analyst'
require_relative '../lib/invoice'
require_relative '../lib/invoice_repository'
require_relative '../lib/transaction'
require_relative '../lib/transaction_repository'
require_relative '../lib/customer'
require_relative '../lib/customer_repository'
require_relative '../lib/invoice_item'
require_relative '../lib/invoice_item_repository'

class SalesAnalystTest < Minitest::Test

  attr_reader :se, :sa
  def setup
    @se = SalesEngine.from_csv({
      :items     => "data/items.csv",
      :merchants => "data/merchants.csv",
      :invoices => "data/invoices.csv",
      :invoice_items => 'data/invoice_items.csv',
      :transactions => 'data/transactions.csv',
      :customers => 'data/customers.csv'
    })
    @sa = SalesAnalyst.new(se)
  end

  def test_sales_analyst_can_be_instantiated_with_sales_engine

    assert @sa
  end

  def test_can_calculate_average_items_per_merchant
    # se = SalesEngine.from_csv({
    #   :items     => "data/items.csv",
    #   :merchants => "data/merchants.csv",
    #   :invoices => "data/invoices.csv"
    # })
    # sa = SalesAnalyst.new(se)
    assert_equal 2.88, sa.average_items_per_merchant
  end

  def test_can_find_squared_difference_for_average_items_per_merchant
    # se = SalesEngine.from_csv({
    #   :items     => "data/items.csv",
    #   :merchants => "data/merchants.csv",
    #   :invoices => "data/invoices.csv"
    # })
    # sa = SalesAnalyst.new(se)
    assert_equal 5034.919999999962, sa.find_squared_difference(se.merchants.item_count_per_merchant_hash, sa.average_items_per_merchant)
  end

  def test_can_find_sample_for_average_items_per_merchant
    # se = SalesEngine.from_csv({
    #   :items     => "data/items.csv",
    #   :merchants => "data/merchants.csv",
    #   :invoices => "data/invoices.csv"
    # })
    # sa = SalesAnalyst.new(se)
    assert_equal 474, sa.find_sample(se.merchants.all)
    assert_equal 1366, sa.find_sample(se.items.all)
  end

  def test_can_find_standard_deviation_for_average_items_per_merchant_standard_deviation
    # se = SalesEngine.from_csv({
    #   :items     => "data/items.csv",
    #   :merchants => "data/merchants.csv",
    #   :invoices => "data/invoices.csv"
    # })
    # sa = SalesAnalyst.new(se)
    assert_equal 3.26, sa.find_standard_deviation(se.merchants.item_count_per_merchant_hash, sa.average_items_per_merchant,se.merchants.all)
  end

  def test_can_calculate_average_items_per_merchant_standard_deviation
    # se = SalesEngine.from_csv({
    #   :items     => "data/items.csv",
    #   :merchants => "data/merchants.csv",
    #   :invoices => "data/invoices.csv"
    #
    # })
    # sa = SalesAnalyst.new(se)
    assert_equal 3.26, sa.average_items_per_merchant_standard_deviation
  end

  def test_can_calculate_number_for_one_std_dev_for_average_items_per_merchant
    # se = SalesEngine.from_csv({
    #   :items     => "data/items.csv",
    #   :merchants => "data/merchants.csv",
    #   :invoices => "data/invoices.csv"
    #
    # })
    # sa = SalesAnalyst.new(se)
    assert_equal 6.14, sa.one_std_dev_for_average_items_per_merchant
  end

  def test_can_calculate_merchants_more_than_one_std_dev_from_avg_number_of_products_offered
    # se = SalesEngine.from_csv({
    #   :items     => "data/items.csv",
    #   :merchants => "data/merchants.csv",
    #   :invoices => "data/invoices.csv"
    #
    # })
    # sa = SalesAnalyst.new(se)
    assert_equal 52, sa.merchants_with_high_item_count.count
  end

  def test_can_calculate_average_item_price_for_specific_merchant_id_for_merchants_with_high_item_count
    # se = SalesEngine.from_csv({
    #   :items     => "data/items.csv",
    #   :merchants => "data/merchants.csv",
    #   :invoices => "data/invoices.csv"
    #
    # })
    # sa = SalesAnalyst.new(se)
    assert_equal BigDecimal, sa.average_item_price_for_merchant(12334105).class
    assert_equal 16.66, sa.average_item_price_for_merchant(12334105).to_f.round(2)
  end

  def test_can_calculate_sum_of_all_the_averages_to_find_average_price_across_all_merchants
    # se = SalesEngine.from_csv({
    #   :items     => "data/items.csv",
    #   :merchants => "data/merchants.csv",
    #   :invoices => "data/invoices.csv"
    #
    # })
    # sa = SalesAnalyst.new(se)

    assert_equal BigDecimal, sa.average_average_price_per_merchant.class
    assert_equal 350.29, sa.average_average_price_per_merchant.to_f.round(2)
  end

  def test_can_find_squared_difference_for_average_item_price
    se = SalesEngine.from_csv({
      :items     => "test/fake_items.csv",
      :merchants => "test/fake_merchants.csv",
      :invoices => "data/invoices.csv",
      :customers => "test/fake_customers.csv",
      :transactions => 'data/transactions.csv',
      :invoice_items => 'data/invoice_items.csv'

    })
    sa = SalesAnalyst.new(se)
    assert_equal 7.684705882352941, sa.find_squared_difference(se.items.item_unit_price_hash, sa.average_price_of_all_items)
  end

  def test_can_find_standard_deviation_for_average_item_price
    se = SalesEngine.from_csv({
      :items     => "test/fake_items.csv",
      :merchants => "test/fake_merchants.csv",
      :invoices => "data/invoices.csv",
      :customers => "test/fake_customers.csv",
      :transactions => 'data/transactions.csv',
      :invoice_items => 'data/invoice_items.csv'

    })
    sa = SalesAnalyst.new(se)
    assert_equal 0.69, sa.find_standard_deviation(se.items.item_unit_price_hash, sa.average_price_of_all_items, se.items.all)
  end

  def test_can_calculate_average_item_price_standard_deviation
    se = SalesEngine.from_csv({
      :items     => "test/fake_items.csv",
      :merchants => "test/fake_merchants.csv",
      :invoices => "data/invoices.csv",
      :customers => "test/fake_customers.csv",
      :transactions => 'data/transactions.csv',
      :invoice_items => 'data/invoice_items.csv'

    })
    sa = SalesAnalyst.new(se)
    assert_equal 0.69, sa.average_item_price_standard_deviation
  end

  def test_can_calculate_number_for_two_std_dev_for_average_item_price
    se = SalesEngine.from_csv({
      :items     => "test/fake_items.csv",
      :merchants => "test/fake_merchants.csv",
      :invoices => "data/invoices.csv",
      :customers => "test/fake_customers.csv",
      :transactions => 'data/transactions.csv',
      :invoice_items => 'data/invoice_items.csv'

    })
    sa = SalesAnalyst.new(se)
    assert_equal 153.22, sa.two_std_dev_for_average_item_price
  end

  def test_can_calculate_golden_items
    se = SalesEngine.from_csv({
      :items     => "test/fake_items.csv",
      :merchants => "test/fake_merchants.csv",
      :invoices => "data/invoices.csv",
      :customers => "test/fake_customers.csv",
      :transactions => 'data/transactions.csv',
      :invoice_items => 'data/invoice_items.csv'

    })
    sa = SalesAnalyst.new(se)
    assert_equal 0, sa.golden_items.count
  end

  def test_can_calculate_average_invoices_per_merchant
    # sales_engine = SalesEngine.from_csv({
    #   :items     => "data/items.csv",
    #   :merchants => "data/merchants.csv",
    #   :invoices => "data/invoices.csv"
    # })
    # sa = SalesAnalyst.new(sales_engine)
    expected = 10.49
    assert_equal expected, sa.average_invoices_per_merchant
    assert_equal Float, expected.class
  end

  def test_can_calculate_squared_difference_for_average_invoices_per_merchant
    # sales_engine = SalesEngine.from_csv({
    #   :items     => "data/items.csv",
    #   :merchants => "data/merchants.csv",
    #   :invoices => "data/invoices.csv"
    # })
    # sa = SalesAnalyst.new(sales_engine)
    assert_equal 5132.74749999999, sa.find_squared_difference(sales_engine.merchants.invoice_count_per_merchant_hash, sa.average_invoices_per_merchant)
  end

  def test_can_find_standard_deviation_for_average_invoices_per_merchant
    # sales_engine = SalesEngine.from_csv({
    #   :items     => "data/items.csv",
    #   :merchants => "data/merchants.csv",
    #   :invoices => "data/invoices.csv"
    # })
    # sa = SalesAnalyst.new(sales_engine)
    assert_equal 3.29, sa.find_standard_deviation(sales_engine.merchants.invoice_count_per_merchant_hash, sa.average_invoices_per_merchant, sales_engine.merchants.all)
  end

  def test_can_calculate_average_invoices_per_merchant_standard_deviation
    # sales_engine = SalesEngine.from_csv({
    #   :items     => "data/items.csv",
    #   :merchants => "data/merchants.csv",
    #   :invoices => "data/invoices.csv"
    # })
    # sa = SalesAnalyst.new(sales_engine)
    assert_equal 3.29, sa.average_invoices_per_merchant_standard_deviation
    assert_equal Float, sa.average_invoices_per_merchant_standard_deviation.class
  end

  def test_can_calculate_two_std_dev_average_invoice_count
    # sales_engine = SalesEngine.from_csv({
    #   :items     => "data/items.csv",
    #   :merchants => "data/merchants.csv",
    #   :invoices => "data/invoices.csv"
    # })
    # sa = SalesAnalyst.new(sales_engine)
    expected = 6.58
    assert_equal expected, sa.two_std_dev_average_invoice_count
  end

  def test_can_calculate_number_for_two_std_dev_above_average_invoice_count
    # sales_engine = SalesEngine.from_csv({
    #   :items     => "data/items.csv",
    #   :merchants => "data/merchants.csv",
    #   :invoices => "data/invoices.csv"
    # })
    # sa = SalesAnalyst.new(sales_engine)
    expected = 17.07
    assert_equal expected, sa.two_std_dev_above_average_invoice_count
    assert_equal Float, expected.class
  end

  def test_can_calculate_two_std_dev_below_average_invoice_count
    # sales_engine = SalesEngine.from_csv({
    #   :items     => "data/items.csv",
    #   :merchants => "data/merchants.csv",
    #   :invoices => "data/invoices.csv"
    # })
    # sa = SalesAnalyst.new(sales_engine)
    expected = 3.91
    assert_equal expected, sa.two_std_dev_below_average_invoice_count
    assert_equal Float, expected.class
  end

  def test_can_calculate_top_performing_merchants
    # sales_engine = SalesEngine.from_csv({
    #   :items     => "data/items.csv",
    #   :merchants => "data/merchants.csv",
    #   :invoices => "data/invoices.csv"
    # })
    # sa = SalesAnalyst.new(sales_engine)
    expected = sa.top_merchants_by_invoice_count

    assert_equal 12, expected.count
    assert_equal Merchant, expected.first.class
  end

  def test_can_calculate_lowest_performing_merchants
    # sales_engine = SalesEngine.from_csv({
    #   :items     => "data/items.csv",
    #   :merchants => "data/merchants.csv",
    #   :invoices => "data/invoices.csv"
    # })
    # sa = SalesAnalyst.new(sales_engine)
    expected = sa.bottom_merchants_by_invoice_count

    assert_equal 4, expected.count
    assert_equal Merchant, expected.first.class
  end

  def test_can_calculate_average_invoices_per_day
    # sales_engine = SalesEngine.from_csv({
    #   :items     => "data/items.csv",
    #   :merchants => "data/merchants.csv",
    #   :invoices => "data/invoices.csv"
    # })
    # sa = SalesAnalyst.new(sales_engine)

    expected = sa.average_invoices_per_day
    assert_equal 712, expected
  end

  def test_can_aggregate_invoices_for_each_week_day
    # sales_engine = SalesEngine.from_csv({
    #   :items     => "data/items.csv",
    #   :merchants => "data/merchants.csv",
    #   :invoices => "data/invoices.csv"
    # })
    # sa = SalesAnalyst.new(sales_engine)

    assert_equal Hash, sa.invoices_for_day_hash.class
  end

  def test_can_calculate_average_invoices_per_day_standard_deviation
    # sales_engine = SalesEngine.from_csv({
    #   :items     => "data/items.csv",
    #   :merchants => "data/merchants.csv",
    #   :invoices => "data/invoices.csv"
    # })
    # sa = SalesAnalyst.new(sales_engine)

    assert_equal 18.07, sa.average_invoices_per_day_standard_deviation
    assert_equal Float, sa.average_invoices_per_day_standard_deviation.class
  end


  def test_can_calculate_one_std_dev_above_average_invoice_count_per_day
    # sales_engine = SalesEngine.from_csv({
    #   :items     => "data/items.csv",
    #   :merchants => "data/merchants.csv",
    #   :invoices => "data/invoices.csv"
    # })
    # sa = SalesAnalyst.new(sales_engine)
    assert_equal 730.07, sa.one_std_dev_above_average_invoice_count
    assert_equal Float, sa.one_std_dev_above_average_invoice_count.class
  end

  def test_can_calculate_which_days_of_the_week_see_the_most_sales
    # sales_engine = SalesEngine.from_csv({
    #   :items     => "data/items.csv",
    #   :merchants => "data/merchants.csv",
    #   :invoices => "data/invoices.csv"
    # })
    # sa = SalesAnalyst.new(sales_engine)
    expected = sa.top_days_by_invoice_count

    assert_equal 1, expected.count
    assert_equal "Wednesday", expected.first
    assert_equal String, expected.first.class
  end

  def test_we_can_get_the_percent_of_invoices_that_have_a_certain_status
    se = SalesEngine.from_csv({
      :items     => "test/fake_items.csv",
      :merchants => "test/fake_merchants.csv",
      :invoices => "data/invoices.csv",
      :customers => "test/fake_customers.csv",
      :transactions => 'data/transactions.csv',
      :invoice_items => 'data/invoice_items.csv'

    })
    sa = SalesAnalyst.new(se)
    assert_equal 29.55, sa.invoice_status(:pending)
    assert_equal 56.95, sa.invoice_status(:shipped)
    assert_equal 13.5, sa.invoice_status(:returned)
  end

  def test_can_calculate_total_rev_by_date
    se = SalesEngine.from_csv({
      :items     => "test/fake_items.csv",
      :merchants => "test/fake_merchants.csv",
      :invoices => "test/fake_invoices.csv",
      :invoice_items => "test/fake_invoice_items.csv",
      :transactions => "test/fake_transactions.csv",
      :customers => "test/fake_customers.csv"
    })
    sa = SalesAnalyst.new(se)
    date = Time.parse("2009-02-07")
    assert_equal 21067.77, @sa.total_revenue_by_date(date).to_f.round(2)
  end


  def test_can_calculate_top_x_performing_merchants_in_terms_of_revenue
    assert_equal 20, sa.top_revenue_earners.count
    assert_equal 10, sa.top_revenue_earners(10).count
  end

  def test_can_find_merchants_with_pending_invoices
    assert_equal 467, sa.merchants_with_pending_invoices.count
  end

  def test_can_find_merchants_with_only_one_item
    assert_equal 243, sa.merchants_with_only_one_item.count
  end

  def test_can_find_merchants_with_only_one_item_registered_in_month
    assert_equal 21, sa.merchants_with_only_one_item_registered_in_month("March").count
    assert_equal 18, sa.merchants_with_only_one_item_registered_in_month("June").count
  end

  def test_can_find_revenue_by_merchant
    assert_equal BigDecimal, sa.revenue_by_merchant(12334194).class
  end

  def test_can_find_most_sold_item_for_merchant
    assert sa.most_sold_item_for_merchant(12334189).map { |item| item.id }.include?(263524984)
    assert_equal  263426351, sa.most_sold_item_for_merchant(12334768)
    assert_equal  263455959, sa.most_sold_item_for_merchant(12337105)
  end

end
