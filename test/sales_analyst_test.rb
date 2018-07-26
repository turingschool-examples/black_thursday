require_relative './test_helper'
require './lib/sales_analyst'
require './lib/sales_engine'

class SalesAnalystTest < Minitest::Test

  def setup
    @se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
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
    assert_equal 1, @sa.group_items_by_merchant[12334141].count
    assert_equal 6, @sa.group_items_by_merchant[12334185].count
  end

  def test_it_can_find_number_of_merchants
    grouped_items = {
                    12334141 => ["item_1", "item_2"],
                    12334185 => ["item_1", "item_2", "item_3"]
    }
    assert_equal 2, @sa.find_number_of_merchants(grouped_items)
  end

  def test_it_can_find_number_items
    grouped_items = {
                    12334141 => ["item_1", "item_2"],
                    12334185 => ["item_1", "item_2", "item_3"]
    }
    assert_equal 5, @sa.find_total_number_of_items(grouped_items)
  end

  def test_it_can_find_average_items_per_merchant
    assert_equal 2.88, @sa.average_items_per_merchant
    assert_equal Float, @sa.average_items_per_merchant.class
  end

  def test_it_can_find_average_items_per_merchant_standard_deviation
    assert_equal 3.26, @sa.average_items_per_merchant_standard_deviation
    assert_equal Float, @sa.average_items_per_merchant_standard_deviation.class
  end

  def test_it_can_find_number_of_items_for_each_merchant
    grouped_items = {
                    12334141 => ["item_1", "item_2"],
                    12334185 => ["item_1", "item_2", "item_3"],
                    12345678 => ["item_1", "item_2", "item_3", "item_4"]
                  }
    assert_equal [2, 3, 4], @sa.items_per_merchant(grouped_items)
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
    assert_equal 6.14, @sa.one_standard_deviation_above
  end

  def test_it_can_find_high_seller_merchants
    skip
    assert_equal 52, @sa.merchants_with_high_item_count.count
    assert_equal Array, @sa.merchants_with_high_item_count.class
    assert_equal Merchant, @sa.merchants_with_high_item_count.first.class
  end

  #--------------------------ITERATION-2-STUFF-------------#

  def test_it_can_group_invoices_by_merchant_id
    assert_equal 7, @sa.group_invoices_by_merchant[12335080].count
    assert_equal 12, @sa.group_invoices_by_merchant[12335955].count
  end

  def test_it_can_find_number_invoices
    grouped_invoices = {
                    12334141 => ["invoice_1", "invoice_2"],
                    12334185 => ["invoice_1", "invoice_2", "invoice_3"]
    }
    assert_equal 5, @sa.find_total_number_of_invoices(grouped_invoices)
  end

  def test_it_can_find_average_invoices_per_merchant
    grouped_invoices = {
                    12334141 => ["invoice_1", "invoice_2"],
                    12334185 => ["invoice_1", "invoice_2", "invoice_3"]
    }
    assert_equal 10.49, @sa.average_invoices_per_merchant
    assert_equal Float, @sa.average_invoices_per_merchant.class
  end

  def test_it_can_find_average_invoices_per_merchant_standard_deviation
    assert_equal 3.29, @sa.average_invoices_per_merchant_standard_deviation
    assert_equal Float, @sa.average_invoices_per_merchant_standard_deviation.class
  end

  def test_it_can_find_number_of_invoices_for_each_merchant
    grouped_invoices = {
                    12334141 => ["invoice_1", "invoice_2"],
                    12334185 => ["invoice_1", "invoice_2", "invoice_3"],
                    12345678 => ["invoice_1", "invoice_2", "invoice_3", "invoice_4"]
                  }
    assert_equal [2, 3, 4], @sa.invoices_per_merchant(grouped_invoices)
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

  def test_it_can_find_two_standard_deviations_above_average
    average_invoices_per_merchant = 5
    average_invoices_per_merchant_standard_deviation = 1
    assert_equal 7, @sa.two_standard_deviations_above(5, 1)
    # assert_equal 17.07, @sa.two_standard_deviations_above
  end

  # def test_it_can_find_top_merchants_by_invoice_count
  # grouped_invoices = {
  #                 12334141 => ["invoice_1", "invoice_2"],
  #                 12334185 => ["invoice_1", "invoice_2", "invoice_3"],
  #                 12345678 => ["invoice_1", "invoice_2", "invoice_3", "invoice_4"]
  #               }
  #   assert_equal 12, @sa.top_merchants_by_invoice_count.count
  #   assert_equal Array, @sa.top_merchants_by_invoice_count.class
  #   assert_equal Merchant, @sa.top_merchants_by_invoice_count.first.class
  # end
end
