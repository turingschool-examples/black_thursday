require './test/test_helper'
require 'pry'
require_relative '../lib/sales_engine'
require_relative '../lib/sales_analyst'
require 'time'


class SalesAnalystTest < Minitest::Test 
  def setup 
    @sales_engine = SalesEngine.new({
    :items     => "./data/items.csv",
    :merchants => "./data/merchants.csv",
    :invoices  => "./data/invoices.csv",
    :transactions => "./data/transactions.csv",
    :customers => "./data/customers.csv",
    :invoice_items => "./data/invoice_items.csv"
     })
    @sales_analyst = @sales_engine.analyst
  end 
  
  def test_it_exists
    assert_instance_of SalesAnalyst, @sales_analyst
  end

  def test_it_has_attributes
    assert_equal SalesEngine, @sales_analyst.sales_engine.class
    assert_equal ItemRepository, @sales_analyst.item_repository.class
    assert_equal 1367, @sales_analyst.item_repository.all.count
    assert_equal MerchantRepository, @sales_analyst.merchant_repository.class
    assert_equal 475, @sales_analyst.merchant_repository.all.count
    assert_equal InvoiceRepository, @sales_analyst.invoice_repository.class
    assert_equal 4985, @sales_analyst.invoice_repository.all.count
    assert_nil @sales_analyst.merchant_id_item_counts
    assert_nil @sales_analyst.item_count_std_dev
    assert_nil @sales_analyst.merchant_id_invoice_counts
    assert_nil @sales_analyst.merchant_id_invoice_counts_std_dev
  end 
  
  def test_merchant_id_item_counts_attribute_can_be_populated
    @sales_analyst.merchant_id_item_counter 
    assert_equal 475, @sales_analyst.merchant_id_item_counts.count 
  end
  
  def test_average_items_per_merchant_standard_deviation_can_be_populated 
    @sales_analyst.merchant_id_item_counter
    @sales_analyst.average_items_per_merchant_standard_deviation
    assert_equal Float, @sales_analyst.item_count_std_dev.class
  end
  
  def test_merchant_id_invoice_counts_attribute_can_be_populated
    @sales_analyst.merchant_id_invoice_counter 
    assert_equal 475, @sales_analyst.merchant_id_invoice_counts.count 
  end 
  
  def test_average_invoices_per_merchant_standard_deviation_can_be_populated 
    @sales_analyst.merchant_id_invoice_counter
    @sales_analyst.average_invoices_per_merchant_standard_deviation 
    assert_equal Float, @sales_analyst.merchant_id_invoice_counts_std_dev.class
  end
  
  def test_average_items_per_merchant_standard_deviation
    assert_equal 3.26, @sales_engine.analyst.average_items_per_merchant_standard_deviation 
    assert_equal Float, @sales_engine.analyst.average_items_per_merchant_standard_deviation.class 
  end 
  
  def test_average_items_per_merchant 
    assert_equal 2.88, @sales_analyst.average_items_per_merchant 
    assert_equal Float, @sales_analyst.average_items_per_merchant.class 
  end
  
  def test_it_sums_differences_squared
    @sales_analyst.sum_of_differences_squared
    assert_equal 5034.92, @sales_analyst.sum_of_differences_squared.round(2)
  end 
  
  def test_it_builds_hash_of_merchant_item_counts
    assert_equal Hash, @sales_analyst.merchant_id_item_counter.class 
    assert_equal 475, @sales_analyst.merchant_id_item_counter.count 
    assert_equal [12334105, 3], @sales_analyst.merchant_id_item_counter.first
  end
  
  def test_it_finds_merchants_with_high_item_count
    @sales_analyst.merchant_id_item_counter
    @sales_analyst.average_items_per_merchant_standard_deviation
    assert_equal Array, @sales_analyst.merchants_with_high_item_count.class 
    assert_equal Merchant, @sales_analyst.merchants_with_high_item_count[0].class
    assert_equal 52, @sales_analyst.merchants_with_high_item_count.count 
  end 
  
  def test_it_finds_ids_with_high_item_count
    assert_equal Array, @sales_analyst.ids_with_high_item_count.class
    assert_equal Array, @sales_analyst.ids_with_high_item_count[0].class
    assert_equal 52, @sales_analyst.ids_with_high_item_count.count
  end
  
  def test_average_average_price_per_merchant
    assert_equal BigDecimal, @sales_analyst.average_average_price_per_merchant.class
    assert_equal 350.29, @sales_analyst.average_average_price_per_merchant
  end 
  
  def test_it_creates_array_of_averages_per_merchant 
    assert_equal Array, @sales_analyst.create_array_of_averages_per_merchant.class
    assert_equal BigDecimal, @sales_analyst.create_array_of_averages_per_merchant[0].class
    assert_equal @sales_analyst.merchant_repository.all.count, @sales_analyst.create_array_of_averages_per_merchant.count
  end
  
  def test_average_item_price_for_merchant 
    assert_equal 16.66, @sales_analyst.average_item_price_for_merchant(12334105)
    assert_equal BigDecimal, @sales_analyst.average_item_price_for_merchant(12334105).class
  end
  
  def test_it_finds_items_by_merchant_id
    assert_equal Array, @sales_analyst.find_items_by_merchant_id(12334159).class 
    assert_equal 10, @sales_analyst.find_items_by_merchant_id(12334159).count 
    assert_equal Item, @sales_analyst.find_items_by_merchant_id(12334159)[0].class
  end 
  
  def test_it_creates_price_array 
    assert_equal Array, @sales_analyst.create_price_array(12334159).class
    assert_equal 10, @sales_analyst.create_price_array(12334159).count
    assert_equal BigDecimal, @sales_analyst.create_price_array(12334159)[0].class
  end 
  
  def test_it_sums_prices_in_price_array
    assert_equal 15, @sales_analyst.sum_prices_in_price_array([1, 2, 3, 4, 5])
  end
  
  def test_it_returns_golden_items 
    assert_equal 5, @sales_analyst.golden_items.length
    assert_equal Item, @sales_analyst.golden_items[0].class
  end
  
  def test_price_standard_deviation
    assert_equal 2899.93, @sales_analyst.price_standard_deviation
  end 
  
  def test_sum_of_price_differences_squared 
    assert_equal BigDecimal, @sales_analyst.sum_of_price_differences_squared.class 
  end 
  
  def test_average_item_price 
    assert_equal BigDecimal, @sales_analyst.average_item_price.class
  end
  
  def test_average_invoices_per_merchant_standard_deviation
    assert_equal 3.29, @sales_engine.analyst.average_invoices_per_merchant_standard_deviation 
    assert_equal Float, @sales_engine.analyst.average_invoices_per_merchant_standard_deviation.class 
  end 
  
  def test_it_sums_inv_differences_squared
    @sales_analyst.sum_of_inv_differences_squared
    assert_equal 5132.75, @sales_analyst.sum_of_inv_differences_squared.round(2)
  end
  
  def test_merchant_id_item_counts_attribute_can_be_populated
    @sales_analyst.merchant_id_invoice_counter 
    assert_equal 475, @sales_analyst.merchant_id_invoice_counts.count 
  end 
  
  def test_average_invoices_per_merchant 
    assert_equal 10.49, @sales_analyst.average_invoices_per_merchant 
    assert_equal Float, @sales_analyst.average_invoices_per_merchant.class 
  end 
  
  def test_it_finds_top_merchants_by_invoice_count
    @sales_analyst.merchant_id_invoice_counter
    @sales_analyst.average_invoices_per_merchant_standard_deviation
    assert_equal Array, @sales_analyst.top_merchants_by_invoice_count.class 
    assert_equal Merchant, @sales_analyst.top_merchants_by_invoice_count[0].class
    assert_equal 12, @sales_analyst.top_merchants_by_invoice_count.count 
  end
  
  def test_it_finds_bottom_merchants_by_invoice_count
    @sales_analyst.merchant_id_invoice_counter
    @sales_analyst.average_invoices_per_merchant_standard_deviation
    assert_equal Array, @sales_analyst.bottom_merchants_by_invoice_count.class 
    assert_equal Merchant, @sales_analyst.bottom_merchants_by_invoice_count[0].class
    assert_equal 4, @sales_analyst.bottom_merchants_by_invoice_count.count 
  end
  
  def test_top_days_by_invoice_count
    assert_equal 1, @sales_analyst.top_days_by_invoice_count.count
    assert_equal "Wednesday", @sales_analyst.top_days_by_invoice_count[0]
    assert_equal String, @sales_analyst.top_days_by_invoice_count[0].class  
  end
  
  def test_standard_deviation_of_invoices_by_day
    assert_equal 16.703, @sales_analyst.standard_deviation_of_invoices_by_day
  end 
  
  def test_arrange_invoices_by_day
    assert_equal 6, @sales_analyst.arrange_invoices_by_day.keys[0]
    assert_equal 7, @sales_analyst.arrange_invoices_by_day.keys.count
    assert_equal Fixnum, @sales_analyst.arrange_invoices_by_day.values[6].class
    assert_equal Fixnum, @sales_analyst.arrange_invoices_by_day.values[3].class
  end 
  
  def test_invoice_status
    assert_equal 29.55, @sales_analyst.invoice_status(:pending)
    assert_equal 56.95, @sales_analyst.invoice_status(:shipped)
    assert_equal 13.5, @sales_analyst.invoice_status(:returned)
  end
  
  def test_invoice_paid_in_full?
    assert_equal true, @sales_analyst.invoice_paid_in_full?(1)
    assert_equal true, @sales_analyst.invoice_paid_in_full?(200)
    assert_equal false, @sales_analyst.invoice_paid_in_full?(203)
    assert_equal false, @sales_analyst.invoice_paid_in_full?(204)
  end
  
  def test_invoice_total 
    assert_equal 21067.77, @sales_analyst.invoice_total(1)
    assert_equal BigDecimal, @sales_analyst.invoice_total(1).class 
  end 
  
  def test_invoice_items_by_invoice_id 
    assert_equal InvoiceItem, @sales_analyst.invoice_items_by_invoice_id(200)[0].class
    assert_equal Array, @sales_analyst.invoice_items_by_invoice_id(200).class
  end 
  
  def test_total_revenue_by_date
    assert_equal BigDecimal, @sales_analyst.total_revenue_by_date(Time.parse("2009-02-07")).class 
    assert_equal 21067.77, @sales_analyst.total_revenue_by_date(Time.parse("2009-02-07")).to_f 
  end 
  
  def test_invoices_by_date 
    assert_equal 1, @sales_analyst.invoices_by_date(Time.parse("2009-02-07")).count
    assert_equal Invoice, @sales_analyst.invoices_by_date(Time.parse("2009-02-07"))[0].class 
  end 
  
  def test_merchants_with_only_one_item
    assert_equal 243, @sales_analyst.merchants_with_only_one_item.count
    assert_equal Merchant, @sales_analyst.merchants_with_only_one_item[0].class
  end 
  
  def test_merchant_ids_with_only_one_item
    assert_equal 243, @sales_analyst.merchant_ids_with_only_one_item.count
    assert_equal Fixnum, @sales_analyst.merchant_ids_with_only_one_item[0].class
  end 
  
  def test_merchants_with_only_one_item_in_month
    assert_equal 18, @sales_analyst.merchants_with_only_one_item_registered_in_month("June").count
    assert_equal Merchant, @sales_analyst.merchants_with_only_one_item_registered_in_month("June")[0].class
  end
  
  def test_revenueby_merchant
    p @sales_analyst.find_items_by_merchant_id(12334194)[1]
    # expected = sales_analyst.revenue_by_merchant(12334194)
    # 
    # expect(expected).to eq BigDecimal.new(expected)
    # expect(expected.class).to eq BigDecimal
  end
  
  def test_merchants_ranked_by_revenue
  end
  
  def test_merchants_ranked_by_revenue 
    p @sales_analyst.merchants_ranked_by_revenue
  end 
  
  def test_merchant_id_revenue_hash 
    p @sales_analyst.merchant_id_revenue_hash 
  end 
  
  def test_revenue_by_merchant
    assert_equal BigDecimal, @sales_analyst.revenue_by_merchant(12334194).class
  end
  
  def test_revenue_hash_by_merchant
    assert_equal Hash, @sales_analyst.revenue_hash_by_merchant_id(12334194).class
    assert_equal 471, @sales_analyst.revenue_hash_by_merchant_id(12334194).count 
  end 
  
  def test_find_all_invoices_paid_in_full 
    p @sales_analyst.find_all_invoices_paid_in_full.count
    p @sales_analyst.find_all_invoices_paid_in_full[0].class
    p @sales_analyst.find_all_invoices_paid_in_full[0]
  end
end 
