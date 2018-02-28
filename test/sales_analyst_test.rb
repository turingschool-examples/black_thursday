require_relative 'test_helper'
require_relative '../lib/sales_analyst'
require_relative '../lib/sales_engine'
require 'pry'

# test for sales analyst class
class SalesAnalystTest < Minitest::Test
  def setup
    @se = SalesEngine.from_csv(items: './test/fixtures/items.csv',
                               merchants: './test/fixtures/merchants.csv',
                               invoices: './test/fixtures/invoices.csv',
                               invoice_items: './test/fixtures/invoice_items.csv',
                               transactions: './test/fixtures/transactions.csv',
                               customers: './test/fixtures/customers.csv')
    @sa = SalesAnalyst.new(@se)
  end

  def test_it_exists
    assert_instance_of SalesAnalyst, @sa
    assert_equal @se,                @sa.sales_engine
  end

  def test_it_can_load_merchants
    assert_instance_of Array,    @sa.merchants
    assert_instance_of Merchant, @sa.merchants[0]
  end

  def test_it_can_load_items
    assert_instance_of Array, @sa.items
    assert_instance_of Item,  @sa.items[0]
  end

  def test_it_can_load_invoices
    assert_instance_of Array,   @sa.invoices
    assert_instance_of Invoice, @sa.invoices[0]
  end

  def test_it_can_load_customers
    assert_instance_of Array,    @sa.customers
    assert_instance_of Customer, @sa.customers[0]
  end

  def test_it_can_count_invoices
    assert_equal [2, 4, 2, 1], @sa.invoice_count
  end

  def test_it_can_average
    assert_equal 1,                @sa.average(3, 3)
    assert_instance_of BigDecimal, @sa.average(3, 3)
  end

  def test_standard_deviation_calc
    assert_equal 1, @sa.standard_deviation([1, 2, 3], 2)
  end

  def test_average_items_per_merchant
    assert_equal 1.25, @sa.average_items_per_merchant
  end

  def test_items_per_merchant_standard_deviation
    assert_equal 1.5, @sa.average_items_per_merchant_standard_deviation
  end

  def test_merchants_with_high_item_count
    high_count = @sa.merchants_with_high_item_count
    assert_instance_of Array,    high_count
    assert_instance_of Merchant, high_count[0]
    assert_equal 2,              high_count[0].id
  end

  def test_average_item_price_for_merchant
    assert_instance_of BigDecimal,        @sa.average_item_price_for_merchant(2)
    assert_equal BigDecimal.new('16.66'), @sa.average_item_price_for_merchant(2)
  end

  def test_find_items_with_merchant_id
    assert_equal 3,          @sa.find_items_with_merchant_id(2).length
    assert_instance_of Item, @sa.find_items_with_merchant_id(2)[0]
    assert_equal 2,          @sa.find_items_with_merchant_id(2)[0].merchant_id
  end

  def test_average_average_price_per_merchant
    assert_equal BigDecimal.new('7.35'), @sa.average_average_price_per_merchant
  end

  def test_all_item_prices
    assert_instance_of Array,      @sa.all_item_prices
    assert_equal 5,                @sa.all_item_prices.length
    assert_instance_of BigDecimal, @sa.all_item_prices[0]
  end

  def test_avg_items_price_standard_deviation
    assert_equal 12.288811984890973, @sa.average_items_price_standard_deviation
  end

  def test_golden_items
    assert_instance_of Array, @sa.golden_items
    assert_equal 0,           @sa.golden_items.length
  end

  def test_average_invoices_per_merchant
    assert_equal 2.25, @sa.average_invoices_per_merchant
  end

  def test_average_invoices_per_merchant_standard_deviation
    assert_equal 1.26, @sa.average_invoices_per_merchant_standard_deviation
  end

  def test_top_merchants_by_invoice_count
    assert_instance_of Array, @sa.top_merchants_by_invoice_count
    assert_equal 0,           @sa.top_merchants_by_invoice_count.length
  end

  def test_bottom_merchants_by_invoice_count
    assert_instance_of Array, @sa.bottom_merchants_by_invoice_count
    assert_equal 0,           @sa.bottom_merchants_by_invoice_count.length
  end

  def test_can_find_how_many_invoices_there_are_per_day
    assert_instance_of Hash, @sa.finding_number_of_invoices_per_day
  end

  def test_average_invoice_per_day
    assert_equal 1.2857142857142858, @sa.average_invoice_per_day
  end

  def test_can_find_number_of_invoices_for_days_of_week
    assert_equal 9, @sa.invoice_dates.length
    assert_equal 2, @sa.finding_number_of_invoices_per_day['Saturday']
  end

  def test_can_find_standard_deviation_for_invoices_on_days
    assert_equal 1.68, @sa.invoice_day_deviation
  end

  def test_can_find_top_days_by_invoice_count
    assert_equal ['Friday'], @sa.top_days_by_invoice_count
  end

  def test_can_find_percentage_of_certain_status
    assert_equal 55.56, @sa.invoice_status(:pending)
    assert_equal 44.44, @sa.invoice_status(:shipped)
  end

  def test_can_find_top_buyers
    assert_instance_of Array,    @sa.top_buyers
    assert_instance_of Customer, @sa.top_buyers[1]
    assert_equal 5,              @sa.top_buyers.length
  end

  def test_it_can_get_invoices
    assert_instance_of Array,   @sa.get_invoices(1)
    assert_instance_of Invoice, @sa.get_invoices(1)[0]
  end

  def test_can_find_one_time_buyers
    assert_instance_of Array,    @sa.one_time_buyers
    assert_instance_of Customer, @sa.one_time_buyers[0]
    assert_equal 1,              @sa.one_time_buyers.length
  end

  def test_one_time_buyers_top_items
    assert_equal [nil], @sa.one_time_buyers_top_items
    assert_equal 1, @sa.one_time_buyers_top_items.length
  end

  def test_find_top_items_method
    parent = @se.customers
    customer = Customer.new({ id: 6,
                              first_name: 'Joan',
                              last_name: 'Clarke',
                              created_at: Time.now,
                              updated_at: Time.now}, parent)
    assert_equal [], @sa.find_top_items(customer, {})
  end

  def test_can_find_invoice_items
    assert_instance_of Hash, @sa.finding_invoice_items(1)
    assert_equal 8,          @sa.finding_invoice_items(1).length
  end

  def test_can_find_number_of_invoice_bought_in_a_year
    assert_equal [], @sa.items_bought_in_year(1, 2013)
  end

  def test_can_find_items_bought_in_a_year
    assert_instance_of Array, @sa.items_bought_in_year(1, 2009)
    assert_equal 16,          @sa.items_bought_in_year(1, 2009).length
  end

  def test_can_find_unpaid_invoices
    assert_instance_of Customer, @sa.customers_with_unpaid_invoices.first
    assert_equal 'Joey',         @sa.customers_with_unpaid_invoices.first.first_name
  end

  def test_can_sort_invoices_by_quantity
    assert_instance_of Hash,    @sa.sorting_invoices_by_quantity
    assert_instance_of Invoice, @sa.sorting_invoices_by_quantity.first.first
    assert_equal 47,            @sa.sorting_invoices_by_quantity.first.first.quantity
  end

  def test_can_find_best_invoice_by_quantity
    assert_instance_of Invoice, @sa.best_invoice_by_quantity
    assert_equal 1,             @sa.best_invoice_by_quantity.id
  end

  def test_can_find_highest_volume_item
    assert_instance_of Array, @sa.highest_volume_items(1)
    assert_equal 3,           @sa.highest_volume_items(1).length
  end

  def test_highest_volume_item_array
    assert_equal [nil], @sa.highest_volume_item_array(@se.invoice_items.all, [2,3])
  end

  def test_find_best_invoice_by_revenue
    assert_instance_of Invoice, @sa.best_invoice_by_revenue
  end

  def test_can_sort_invoices_by_revenue
    assert_instance_of Hash,    @sa.sorting_invoices_by_revenue
    assert_instance_of Invoice, @sa.sorting_invoices_by_revenue.first.first
  end
end
