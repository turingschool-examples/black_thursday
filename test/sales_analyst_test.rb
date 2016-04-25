require_relative 'test_helper'
require_relative '../lib/sales_analyst'
require_relative '../lib/sales_engine'

class SalesAnalystTest < Minitest::Test

  attr_reader :merch_repo, :se, :sa

  def setup
    @se = SalesEngine.from_csv({
      :items     => "./data/small_items.csv",
      :merchants => "./data/small_merchants.csv",})
    @sa = SalesAnalyst.new(se)

    @se.merchant_repo = MerchantRepository.new(nil, se)
    @se.item_repo = ItemRepository.new(nil, se)
    @se.invoice_repo = InvoiceRepository.new(nil, se)
    @se.invoice_item_repo = InvoiceItemRepository.new(nil, se)
    # @se.transaction_repo = TransactionRepository.new(nil, se)
    # @se.customer_repo = CustomerRepository.new(nil, se)

    setup_merchants
    setup_items
    setup_invoices
    setup_invoice_items
    # setup_transactions
    # setup_customers
  end


  def test_average_items_per_merchant_gives_correct_average
    assert_equal 2.33, sa.average_items_per_merchant
  end

  def test_sum_will_sum_array_correctly
    assert_equal 6, sa.sum([1,2,3])
  end

  def test_average_an_array_is_correct
    assert_equal 2, sa.average([1,2,3])
  end

  def test_standard_deviation_works_on_an_array
    assert_equal 1.0, sa.standard_deviation([1,2,3])
    assert_equal 2.65, sa.standard_deviation([1,2,6])
  end

  def test_generates_array_of_item_counts_per_merchant
    assert_equal  [1, 2, 4], sa.item_count_by_merchant
  end

  def test_calculates_std_dev_of_item_counts
    assert_equal 1.53, sa.average_items_per_merchant_standard_deviation
  end

  def test_identifes_all_merchants_with_high_item_counts
    assert_equal 1, sa.merchants_with_high_item_count.length
  end

  def test_identifes_correct_merchants_with_high_item_counts
    assert_equal 3, sa.merchants_with_high_item_count[0].id
  end

  def test_identifies_average_item_price_for_merchant
    assert_equal  14.38, sa.average_item_price_for_merchant(3)
  end

  def test_identifies_average_item_price_for_merchant_as_BD
    assert_equal  BigDecimal, sa.average_item_price_for_merchant(3).class
  end

  def test_identifies_avg_avg_price_per_merchant_as_BD
    assert_equal  BigDecimal, sa.average_average_price_per_merchant.class
  end

  def test_identifies_avg_avg_price_for_merchant
    assert_equal  5.63, sa.average_average_price_per_merchant.to_f
  end

  def test_generates_array_of_item_prices
    sorted = [1.0, 1.0, 2.0, 5.0, 10.0, 12.5, 30.0]
    assert_equal  sorted, sa.item_price_array
  end

  def test_calculates_std_dev_of_item_prices
    assert_equal 10.38, sa.item_price_standard_deviation
  end

  def test_average_item_price
    assert_equal 8.79, sa.item_price_average
  end

  def test_identifes_all_golden_items
    assert_equal 1, sa.golden_items.length
  end

  def test_identifes_correct_golden_item
    assert_equal 6, sa.golden_items[0].id
  end

  def test_average_ivoices_per_merchant_gives_correct_average
    assert_equal 2.33, sa.average_invoices_per_merchant
  end

  def test_standard_deviation_can_calc_for_invoices
    assert_equal 2.31, sa.average_invoices_per_merchant_standard_deviation
  end

  def test_we_can_find_top_performing_merchants
    assert_equal [], sa.top_merchants_by_invoice_count
  end

  def test_we_can_retrieve_the_lowest_performing_merchants
    assert_equal [], sa.bottom_merchants_by_invoice_count
  end

  def test_find_day_of_week
    assert_equal "Thursday", sa.find_day_of_week(Time.parse("2016-04-21"))
  end

  def test_we_can_group_invoices_by_day
    assert_equal 4, sa.group_invoices_by_day["Monday"].length
    assert_equal 2, sa.group_invoices_by_day["Tuesday"].length
  end

  def test_we_can_group_invoices_by_day_count
    assert_equal 4, sa.group_invoices_by_day_count["Monday"]
    assert_equal 2, sa.group_invoices_by_day_count["Tuesday"]
  end

  def test_we_can_return_average_invoices_per_day
    assert_equal 2.33, sa.average_invoices_per_day
  end

  def test_we_can_return_top_days_by_invoice_count
    assert_equal ["Monday"], sa.top_days_by_invoice_count
  end

  def test_we_can_hash_by_invoice_status
    assert_equal 3, sa.group_invoices_status[:shipped].length
  end

  def test_we_can_percentage_of_invoices_with_given_status
    assert_equal 42.86, sa.invoice_status(:pending)
    assert_equal 42.86, sa.invoice_status(:shipped)
    assert_equal 14.29, sa.invoice_status(:returned)
  end

  def test_it_finds_threshold_for_postitive_std_devs
    assert_equal 8.55, sa.threshold([10, 8, 3, 4, 5, 6, 7], 1)
    assert_equal 10.96, sa.threshold([10, 8, 3, 4, 5, 6, 7], 2)
  end

  def test_it_finds_threshold_for_negative_std_devs
    assert_equal 3.73, sa.threshold([10, 8, 3, 4, 5, 6, 7], -1)
    assert_equal 1.32, sa.threshold([10, 8, 3, 4, 5, 6, 7], -2)
  end

  def setup_merchants
    @se.merchant_repo.add_new({:id => 1, :name => "Merch1", :created_at => "2016-04-22"}, @se)
    @se.merchant_repo.add_new({:id => 2, :name => "Merch2", :created_at => "2016-10-22"}, @se)
    @se.merchant_repo.add_new({:id => 3, :name => "Merch3", :created_at => "2016-08-22"}, @se)
  end

  def setup_items
    @se.item_repo.add_new({:id => 1, :name => "Item1", :unit_price => 200, :merchant_id => 1}, @se)
    @se.item_repo.add_new({:id => 2, :name => "Item2", :unit_price => 100, :merchant_id => 1}, @se)

    @se.item_repo.add_new({:id => 3, :name => "Item3", :unit_price => 100, :merchant_id => 2}, @se)

    @se.item_repo.add_new({:id => 4, :name => "Item4", :unit_price => 500, :merchant_id => 3}, @se)
    @se.item_repo.add_new({:id => 5, :name => "Item5", :unit_price => 1000, :merchant_id => 3}, @se)
    @se.item_repo.add_new({:id => 6, :name => "Item6", :unit_price => 3000, :merchant_id => 3}, @se)
    @se.item_repo.add_new({:id => 7, :name => "Item7", :unit_price => 1250, :merchant_id => 3}, @se)
  end

  def setup_invoices
    @se.invoice_repo.add_new({:id => 1, :customer_id => 1, :merchant_id => 1, :status => "shipped", :created_at => "2016-04-18"}, @se)
    @se.invoice_repo.add_new({:id => 2, :customer_id => 1, :merchant_id => 1, :status => "pending", :created_at => "2016-04-19"}, @se)
    @se.invoice_repo.add_new({:id => 3, :customer_id => 2, :merchant_id => 2, :status => "returned", :created_at => "2016-04-19"}, @se)
    @se.invoice_repo.add_new({:id => 4, :customer_id => 3, :merchant_id => 3, :status => "shipped", :created_at => "2016-04-20"}, @se)
    @se.invoice_repo.add_new({:id => 5, :customer_id => 1, :merchant_id => 1, :status => "shipped", :created_at => "2016-04-18"}, @se)
    @se.invoice_repo.add_new({:id => 6, :customer_id => 1, :merchant_id => 1, :status => "pending", :created_at => "2016-04-18"}, @se)
    @se.invoice_repo.add_new({:id => 7, :customer_id => 1, :merchant_id => 1, :status => "pending", :created_at => "2016-04-18"}, @se)
  end

  def setup_invoice_items
    @se.invoice_item_repo.add_new({:id => 1, :invoice_id => 1, :item_id => 1, :unit_price => "190", :quantity => "1", :created_at => "2016-04-21"}, @se)
    @se.invoice_item_repo.add_new({:id => 2, :invoice_id => 2, :item_id => 1, :unit_price => "190", :quantity => "1", :created_at => "2016-04-21"}, @se)
    @se.invoice_item_repo.add_new({:id => 3, :invoice_id => 2, :item_id => 2, :unit_price => "95", :quantity => "2", :created_at => "2016-04-21"}, @se)
    @se.invoice_item_repo.add_new({:id => 4, :invoice_id => 2, :item_id => 2, :unit_price => "100", :quantity => "3", :created_at => "2016-04-21"}, @se)
    @se.invoice_item_repo.add_new({:id => 5, :invoice_id => 3, :item_id => 3, :unit_price => "95", :quantity => "1", :created_at => "2016-04-18"}, @se)
    @se.invoice_item_repo.add_new({:id => 6, :invoice_id => 4, :item_id => 4, :unit_price => "500", :quantity => "2", :created_at => "2016-04-20"}, @se)
    @se.invoice_item_repo.add_new({:id => 7, :invoice_id => 4, :item_id => 5, :unit_price => "1000", :quantity => "1", :created_at => "2016-04-20"}, @se)
    @se.invoice_item_repo.add_new({:id => 8, :invoice_id => 4, :item_id => 6, :unit_price => "2900", :quantity => "1", :created_at => "2016-04-20"}, @se)
    @se.invoice_item_repo.add_new({:id => 9, :invoice_id => 4, :item_id => 7, :unit_price => "1250", :quantity => "1", :created_at => "2016-04-20"}, @se)
    @se.invoice_item_repo.add_new({:id => 10, :invoice_id => 5, :item_id => 5, :unit_price => "1000", :quantity => "1", :created_at => "2016-04-18"}, @se)
    @se.invoice_item_repo.add_new({:id => 11, :invoice_id => 6, :item_id => 6, :unit_price => "2900", :quantity => "1", :created_at => "2016-04-21"}, @se)
    @se.invoice_item_repo.add_new({:id => 12, :invoice_id => 7, :item_id => 7, :unit_price => "1250", :quantity => "1", :created_at => "2016-04-20"}, @se)
  end

  def setup_transactions
    @se.transaction_repo.add_new({:id => 1, :invoice_id => 1, :result => "success"}, @se)
    @se.transaction_repo.add_new({:id => 2, :invoice_id => 2, :result => "success"}, @se)
    @se.transaction_repo.add_new({:id => 3, :invoice_id => 3, :result => "success"}, @se)
    @se.transaction_repo.add_new({:id => 4, :invoice_id => 4, :result => "success"}, @se)
    @se.transaction_repo.add_new({:id => 5, :invoice_id => 5, :result => "success"}, @se)
    @se.transaction_repo.add_new({:id => 6, :invoice_id => 6, :result => "failed"}, @se)
    @se.transaction_repo.add_new({:id => 7, :invoice_id => 7, :result => "failed"}, @se)
  end

  def setup_customers
    @se.transaction_repo.add_new({:id => 1, :first_name => "Kerry"}, @se)
    @se.transaction_repo.add_new({:id => 2, :first_name => "Colin"}, @se)
    @se.transaction_repo.add_new({:id => 3, :first_name => "Fake"}, @se)
  end

end
