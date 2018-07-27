require_relative './test_helper'
require './lib/sales_analyst'
require './lib/sales_engine'

class SalesAnalystTest < Minitest::Test

  def setup
    @se = SalesEngine.from_csv({
      :items     =>  "./data/fake_item_csv.csv",
      # "./data/items.csv",
      :merchants => "./data/fake_merchant_csv.csv",
      :invoices => "./data/invoices.csv"
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
    assert_equal 5, @sa.find_number_of_merchants
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
  # (9/1 + (10+11)/2 + (12+13+14)/3 + (15+16+17+18)/4 + (19+20+21)/3)/5 = 13.8
    assert_equal 13.8, @sa.average_average_price_per_merchant
    assert_equal BigDecimal, @sa.average_average_price_per_merchant.class
  end

  def test_it_can_find_average_item_prices_for_each_merchant
    assert_equal 5, @sa.average_item_prices_for_each_merchant.count
    assert_equal BigDecimal, @sa.average_item_prices_for_each_merchant[0].class
  end

  def test_it_can_find_item_price_average
    assert_equal 15.00, @sa.item_price_average
  end

  def test_it_can_find_all_item_prices
    assert_equal 13, @sa.all_item_prices.count
  end

  def test_it_can_find_standard_deviation_for_item_price
    assert_equal 3.89, @sa.standard_deviation_for_item_price
  end

  def test_it_can_find_golden_items # items where price >= $20.78
    skip
    assert_equal 2, @sa.golden_items.count
    assert_equal Item, @sa.golden_items.class
  end


  #--------------------------ITERATION-2-STUFF-------------#
  #
  # def test_it_can_group_invoices_by_merchant_id
  #   assert_equal 7, @sa.group_invoices_by_merchant[12335080].count
  #   assert_equal 12, @sa.group_invoices_by_merchant[12335955].count
  # end

  # def test_it_can_find_number_invoices
  #   grouped_invoices = {
  #                   12334141 => ["invoice_1", "invoice_2"],
  #                   12334185 => ["invoice_1", "invoice_2", "invoice_3"]
  #   }
  #   assert_equal 5, @sa.find_total_number_of_invoices(grouped_invoices)
  # end
  #
  # def test_it_can_find_average_invoices_per_merchant
  #   assert_equal 10.49, @sa.average_invoices_per_merchant
  #   assert_equal Float, @sa.average_invoices_per_merchant.class
  # end
  #
  # def test_it_can_find_average_invoices_per_merchant_standard_deviation
  #   assert_equal 3.29, @sa.average_invoices_per_merchant_standard_deviation
  #   assert_equal Float, @sa.average_invoices_per_merchant_standard_deviation.class
  # end
  #
  # def test_it_can_find_number_of_invoices_for_each_merchant
  #   grouped_invoices = {
  #                   12334141 => ["invoice_1", "invoice_2"],
  #                   12334185 => ["invoice_1", "invoice_2", "invoice_3"],
  #                   12345678 => ["invoice_1", "invoice_2", "invoice_3", "invoice_4"]
  #                 }
  #   assert_equal [2, 3, 4], @sa.invoices_per_merchant(grouped_invoices)
  # end

  # def test_it_can_find_variance
  #   invoice_count_array = [2, 3, 4, 3, 5]
  #   average = 3.4
  #   assert_equal 5.2, @sa.variance(average, invoice_count_array)
  # end
  #
  # def test_it_can_find_square_root_of_variance
  #   variance = 5.2
  #   invoices_per_merchant = [2, 3, 4, 3, 5]
  #   assert_equal 1.14, @sa.square_root_of_variance(variance, invoices_per_merchant)
  # end
  #
  # def test_it_can_find_two_standard_deviations_above_average
  #   assert_equal 17.07, @sa.two_standard_deviations_above
  # end
  #
  # def test_it_can_find_top_merchants_by_invoice_count
  #   skip
  #   assert_equal 12, @sa.top_merchants_by_invoice_count.count
  #   assert_equal Array, @sa.top_merchants_by_invoice_count.class
  #   assert_equal Merchant, @sa.top_merchants_by_invoice_count.first.class
  # end
  #
  # def test_it_can_find_two_standard_deviations_below_average
  #   assert_equal 3.91, @sa.two_standard_deviations_below
  # end
  #
  # def test_it_can_find_bottom_merchants_by_invoice_count
  #   skip
  #   assert_equal 4, @sa.bottom_merchants_by_invoice_count.count
  #   assert_equal Array, @sa.bottom_merchants_by_invoice_count.class
  #   assert_equal Merchant, @sa.bottom_merchants_by_invoice_count.first.class
  # end
end
