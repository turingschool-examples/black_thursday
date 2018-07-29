require_relative './test_helper'
require './lib/sales_analyst'
require './lib/sales_engine'

class SalesAnalystTest < Minitest::Test

  def setup
    @se = SalesEngine.from_csv({
      :items     =>  "./data/fake_item_csv.csv",
      # "./data/items.csv",
      :merchants => "./data/fake_merchant_csv.csv",
      :invoices => "./data/fake_invoice_csv.csv"
    })

    @sa = SalesAnalyst.new(@se)
  end

  def test_it_exists
    assert_instance_of SalesAnalyst, @sa
  end

  def test_it_can_create_instance_of_sales_engine
    assert_instance_of SalesEngine, @se
  end

  def test_it_can_group_items_by_merchant_id
    assert_equal 1, @sa.group_items_by_merchant[1].count
    assert_equal 3, @sa.group_items_by_merchant[3].count
  end

  def test_it_can_find_number_of_merchants
    assert_equal 5, @sa.find_number_of_merchants_for_items
  end

  def test_it_can_find_number_items
    assert_equal 13, @sa.find_total_number_of_items
  end

  def test_it_can_find_average_items_per_merchant
    # ((1/1)+(2/1)+(3/1)+(4/1)+(3/1))/5 = 13/5 = 2.6 avg
    assert_equal 2.6, @sa.average_items_per_merchant
    assert_equal Float, @sa.average_items_per_merchant.class
  end

  def test_it_can_find_average_items_per_merchant_standard_deviation
    # sqrt(((1-2.6)^2+(2-2.6)^2+(3-2.6)^2+(4-2.6)^2+(3-2.6)^2)/4) = 1.14 sd
    assert_equal 1.14, @sa.average_items_per_merchant_standard_deviation
    assert_equal Float, @sa.average_items_per_merchant_standard_deviation.class
  end

  def test_it_can_find_number_of_items_for_each_merchant
    assert_equal [1, 2, 3, 4, 3], @sa.items_per_merchant
  end

  def test_it_can_find_variance
    item_count_array = [2, 3, 4, 3, 5]
    average = 3.4
    assert_equal 5.2, @sa.variance(average, item_count_array)
  end

  def test_it_can_find_square_root_of_variance
    v = 5.2
    ipm = [2, 3, 4, 3, 5]
    assert_equal 1.14, @sa.square_root_of_variance(v, ipm)
  end

  def test_it_can_find_one_stnd_deviation_above_average
    # avg + sd = 2.60 + 1.14 = 3.74
    assert_equal 3.74, @sa.items_one_standard_deviation_above
  end

  def test_it_can_zip_merchant_ids_and_item_quantities
    # merchant id first, then item quantity
    expected = [[1, 1], [2, 2], [3, 3], [4, 4], [5, 3]]
    assert_equal expected, @sa.item_amount_per_merchant
  end

  def test_it_can_find_high_seller_merchants
    # high seller merchants have >= 3.74 items
    assert_equal 1, @sa.merchants_with_high_item_count.count
    assert_equal Array, @sa.merchants_with_high_item_count.class
    assert_equal Merchant, @sa.merchants_with_high_item_count.first.class
  end

  def test_it_can_find_average_item_price_for_single_merchant
    assert_equal 16.5, @sa.average_item_price_for_merchant(4)
    assert_equal BigDecimal, @sa.average_item_price_for_merchant(4).class
  end

  def test_it_can_find_number_of_merchants
    assert_equal 5, @sa.number_of_merchants
  end

  def test_it_can_find_average_average_price_per_merchant
  # (9/1 + (10+11)/2 + (12+13+14)/3 + (15+16+17+18)/4 + (19+20+50)/3)/5 = 15.73
    assert_equal 15.73, @sa.average_average_price_per_merchant
    assert_equal BigDecimal, @sa.average_average_price_per_merchant.class
  end

  def test_it_can_find_average_item_prices_for_each_merchant
    assert_equal 5, @sa.average_item_prices_for_each_merchant.count
    assert_equal BigDecimal, @sa.average_item_prices_for_each_merchant[0].class
  end

  def test_it_can_find_item_price_average
    # (9+10+11+12+13+14+15+16+17+18+19+20+50)/13 = 17.23
    assert_equal 17.23, @sa.item_price_average
  end

  def test_it_can_find_all_item_prices
    assert_equal 13, @sa.all_item_prices.count
  end

  def test_it_can_find_standard_deviation_for_item_price
    # sqrt(((9-17.23)^2 +(10-17.23)^2 +(11-17.23)^2 +(12-17.23)^2+(13-17.23)^2 + (14-17.23)^2+(15-17.23)^2+(16-17.23)^2+(17-17.23)^2+(18-17.23)^2+(19-17.23)^2+(20-17.23)^2+(50-17.23)^2)/12) = 10.43
    assert_equal 10.43, @sa.standard_deviation_for_item_price
  end

  def test_it_can_find_golden_items
    # items where price >= $38.09 or 2 standard deviations above average price
    assert_equal 1, @sa.golden_items.count
    # assert_equal Item, @sa.golden_items.class
  end


  #--------------------------ITERATION-2-STUFF-------------#

  def test_it_can_group_invoices_by_merchant_id
    assert_equal 1, @sa.group_invoices_by_merchant[1].count
    assert_equal 3, @sa.group_invoices_by_merchant[3].count
  end

  def test_it_can_find_number_invoices
    assert_equal 13, @sa.find_total_number_of_invoices
  end

  def test_it_can_find_average_invoices_per_merchant
    assert_equal 2.6, @sa.average_invoices_per_merchant
    assert_equal Float, @sa.average_invoices_per_merchant.class
  end

  def test_it_can_find_average_invoices_per_merchant_standard_deviation
    assert_equal 1.14, @sa.average_invoices_per_merchant_standard_deviation
    assert_equal Float, @sa.average_invoices_per_merchant_standard_deviation.class
  end

  def test_it_can_find_number_of_invoices_for_each_merchant
    assert_equal [1, 2, 3, 4, 3], @sa.invoices_per_merchant
  end

  def test_it_can_find_variance
    invoice_count_array = [2, 3, 4, 3, 5]
    average = 3.4
    assert_equal 5.2, @sa.variance(average, invoice_count_array)
  end

  def test_it_can_find_square_root_of_variance
    variance = 5.2
    invoices_per_merchant = [2, 3, 4, 3, 5]
    assert_equal 1.14, @sa.square_root_of_variance(variance, invoices_per_merchant)
  end

  def test_it_can_find_invoices_two_standard_deviations_above_average
    assert_equal 4.88, @sa.invoices_two_standard_deviations_above
  end

  def test_it_groups_top_merchants_by_invoice_count_over_two_standard_deviations # > 2sd above avg
    assert_equal 0, @sa.top_merchants_by_invoice_count.count
    assert_equal ([]), @sa.bottom_merchants_by_invoice_count
  end

  def test_it_can_find_two_standard_deviations_below_average
    assert_equal 0.32, @sa.invoices_two_standard_deviations_below
  end

  def test_it_groups_bottom_merchants_by_invoice_count_below_two_standard_deviations
    assert_equal 0, @sa.bottom_merchants_by_invoice_count.count
    assert_equal ([]), @sa.bottom_merchants_by_invoice_count
  end
# On which days are invoices created at more than one standard deviation above the mean?

  # def test_it_can_convert_numerical_date_to_week_day
  #   assert_equal "Saturday", @sa.weekday("2018-07-28")
  # end

  def test_it_can_group_invoices_by_date
    assert_equal 7, @sa.group_invoices_by_day_created.count
  end

  def test_it_can_find_number_of_invoices_per_day
    assert_equal 4, @sa.group_invoices_by_day_created[0].count #Sunday
    assert_equal 1, @sa.group_invoices_by_day_created[1].count #Monday
    assert_equal 1, @sa.group_invoices_by_day_created[2].count #Tuesday
    assert_equal 1, @sa.group_invoices_by_day_created[3].count #Wednesday
    assert_equal 1, @sa.group_invoices_by_day_created[4].count #Thursday
    assert_equal 2, @sa.group_invoices_by_day_created[5].count #Friday
    assert_equal 3, @sa.group_invoices_by_day_created[6].count #Saturday
  end

  def test_it_can_find_number_of_days_for_invoices
    assert_equal 7, @sa.find_number_of_days_for_invoices
  end

  def test_it_can_find_total_number_of_invoices
    assert_equal 13, @sa.find_total_number_of_invoices
  end

  def test_it_can_find_average_number_of_invoices_per_day
    assert_equal 1.86, @sa.average_invoices_per_day
  end

  def test_it_can_find_average_invoices_per_day_standard_deviation
    assert_equal 1.21, @sa.average_invoices_per_day_standard_deviation
    assert_equal Float, @sa.average_invoices_per_day_standard_deviation.class
  end

  def test_it_can_find_invoices_per_day_one_standard_deviation_above_average
    assert_equal 3.07, @sa.invoices_per_day_one_standard_deviation_above
  end

  def test_it_groups_top_days_by_invoice_count_over_one_standard_deviation
    assert_equal 1, @sa.top_days_by_invoice_count.count
    assert_equal (["Sunday"]), @sa.top_days_by_invoice_count
  end

# What percentage of invoices are shipped vs pending vs returned? (takes symbol as argument)
  def test_it_can_find_percentage_of_invoices
    skip
    assert_equal 46.15, @sa.invoice_status(:pending)
    assert_equal 46.15, @sa.invoice_status(:shipped)
    assert_equal 7.7, @sa.invoice_status(:returned)
  end

  def test_it_can_group_invoices_by_status
    assert_equal 3, @sa.group_invoices_by_status.count
    expected = (["returned","shipped","pending"])
    assert_equal expected, @sa.group_invoices_by_status.keys
    assert_equal 1, @sa.group_invoices_by_status["returned"].count
    assert_equal 6, @sa.group_invoices_by_status["shipped"].count
    assert_equal 6, @sa.group_invoices_by_status["shipped"].count
  end
end
