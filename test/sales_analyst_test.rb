require_relative '../test/test_helper'
require_relative '../lib/sales_analyst'
require_relative '../lib/sales_engine'


class SalesAnalystTest < Minitest::Test

  def test_it_can_calculate_average_items_per_merchant
    skip
    se = SalesEngine.from_csv({
        :items     => "./data/items.csv",
        :merchants => "./data/merchants.csv",
      })
    sa = se.analyst
    assert_equal 2.88, sa.average_items_invoices_per_merchant(sa.item_repo)
  end

  def test_it_can_get_array_of_items_per_merchant
    skip
    se = SalesEngine.from_csv({
        :items     => "./data/items.csv",
        :merchants => "./data/merchants.csv",
      })
    sa = se.analyst
    assert_equal 475, sa.items_per_merchant_array(sa.item_repo).length
  end

  def test_it_can_take_difference_between_a_set_and_mean_and_square_it
    skip
    se = SalesEngine.from_csv({
        :items     => "./data/items.csv",
        :merchants => "./data/merchants.csv",
      })
    sa = se.analyst
    assert_equal 5034.919999999962, sa.subtract_square_sum_array_for_items_per_merchant(sa.item_repo)
  end

  def test_it_can_sum_array
    skip
    se = SalesEngine.from_csv({
        :items     => "./data/items.csv",
        :merchants => "./data/merchants.csv",
      })
    sa = se.analyst
    assert_equal 15, sa.sum([1, 2, 3, 4, 5])
  end

  def test_it_can_calculate_average_items_per_merchange_st_dev
    skip
    se = SalesEngine.from_csv({
        :items     => "./data/items.csv",
        :merchants => "./data/merchants.csv",
      })
    sa = se.analyst
    assert_equal 3.26, sa.per_merchant_standard_deviation(sa.item_repo)
  end

  def test_it_can_return_a_hash_of_merchants_with_their_items
    skip
    se = SalesEngine.from_csv({
        :items     => "./data/items.csv",
        :merchants => "./data/merchants.csv",
      })
    sa = se.analyst
    assert_equal 475, sa.merchant_hash(sa.item_repo).length
  end

  def test_it_can_return_a_hash_of_merchants_and_items_above_one_stand_deviation
    skip
    se = SalesEngine.from_csv({
        :items     => "./data/items.csv",
        :merchants => "./data/merchants.csv",
      })
    sa = se.analyst
    assert sa.merchants_with_high_item_count_hash.all? do |item_array|
      item_array.count >= 6.14
    end
  end

  def test_it_can_return_merchants_above_one_stand_deviation_in_an_array
    skip
    se = SalesEngine.from_csv({
        :items     => "./data/items.csv",
        :merchants => "./data/merchants.csv",
      })
    sa = se.analyst
    assert_equal 52, sa.merchants_with_high_item_count.count
  end

  def test_it_can_return_average_item_price_per_merchant
    skip
    se = SalesEngine.from_csv({
        :items     => "./data/items.csv",
        :merchants => "./data/merchants.csv",
      })
    sa = se.analyst
    assert_instance_of BigDecimal, sa.average_item_price_for_merchant(12334105)
    assert_equal 16.66 , sa.average_item_price_for_merchant(12334105)
  end

  def test_it_can_find_the_global_average
    skip
    se = SalesEngine.from_csv({
        :items     => "./data/items.csv",
        :merchants => "./data/merchants.csv",
      })
    sa = se.analyst
    assert_instance_of BigDecimal, sa.average_average_price_per_merchant
    assert_equal 350.29 , sa.average_average_price_per_merchant
  end

  def test_it_can_find_golden_items
    skip
    se = SalesEngine.from_csv({
        :items     => "./data/items.csv",
        :merchants => "./data/merchants.csv",
      })
    sa = se.analyst
    assert_equal 5, sa.golden_items.count
  end

  def test_it_can_average_invoices_per_merchant
    skip
    se = SalesEngine.from_csv({
        :items     => "./data/items.csv",
        :merchants => "./data/merchants.csv",
        :invoices => "./data/invoices.csv"
      })
    sa = se.analyst
    assert_equal 10.49, sa.average_items_invoices_per_merchant(sa.invoice_repo)
  end

  def test_it_can_average_invoice_per_merch_std_dev
    skip
    se = SalesEngine.from_csv({
        :items     => "./data/items.csv",
        :merchants => "./data/merchants.csv",
        :invoices => "./data/invoices.csv"
      })
    sa = se.analyst
    assert_equal 3.29, sa.average_invoices_per_merchant_standard_deviation
  end

  def test_it_returns_top_performing_merchants_by_invoice_count
    skip
    se = SalesEngine.from_csv({
        :items     => "./data/items.csv",
        :merchants => "./data/merchants.csv",
        :invoices => "./data/invoices.csv"
      })
    sa = se.analyst
    assert_instance_of Merchant, sa.top_merchants_by_invoice_count[0]
    assert_equal 12, sa.top_merchants_by_invoice_count.length

  end

  def test_it_can_find_bottom_merchants_by_invoice_count
    skip
      se = SalesEngine.from_csv({
          :items     => "./data/items.csv",
          :merchants => "./data/merchants.csv",
          :invoices => "./data/invoices.csv"
        })
      sa = se.analyst
      assert_instance_of Merchant, sa.bottom_merchants_by_invoice_count[0]
      assert_equal 4, sa.bottom_merchants_by_invoice_count.length
  end

  def test_it_can_find_days_of_week_with_most_sales
    skip
    se = SalesEngine.from_csv({
        :items     => "./data/items.csv",
        :merchants => "./data/merchants.csv",
        :invoices => "./data/invoices.csv"
      })
    sa = se.analyst
    assert_instance_of Array, sa.top_days_by_invoice_count
    assert_equal 1, sa.top_days_by_invoice_count.length
    assert_equal ["Wednesday"], sa.top_days_by_invoice_count
  end

  def test_it_can_return_percentage_of_invoices_by_status
    skip
    se = SalesEngine.from_csv({
        :items     => "./data/items.csv",
        :merchants => "./data/merchants.csv",
        :invoices => "./data/invoices.csv"
      })
    sa = se.analyst
    assert_equal 29.55, sa.invoice_status(:pending)
    assert_equal 56.95, sa.invoice_status(:shipped)
    assert_equal 13.5, sa.invoice_status(:returned)
  end

  def test_it_can_return_if_an_invoice_is_paid_in_full
    skip
    se = SalesEngine.from_csv({
        :transactions => "./data/transactions.csv"
      })
    sa = se.analyst
    assert sa.invoice_paid_in_full?(1)
    refute sa.invoice_paid_in_full?(203)
    assert sa.invoice_paid_in_full?(200)
    refute sa.invoice_paid_in_full?(204)
  end

  def test_it_can_return_invoice_dollar_amount
    skip
    se = SalesEngine.from_csv({
        :invoice_items => "./data/invoice_items.csv"
      })
    sa = se.analyst
    assert_equal 21067.77, sa.invoice_total(1).to_f
    assert_instance_of BigDecimal, sa.invoice_total(1)
  end

  def test_it_returns_total_revenue_by_date
    skip
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoice_items => "./data/invoice_items.csv",
      :invoices => "./data/invoices.csv",
        })
    sa = se.analyst
    assert_instance_of BigDecimal, sa.total_revenue_by_date(Time.parse("2009-02-07"))
    assert_equal 21067.77, sa.total_revenue_by_date(Time.parse("2009-02-07")).to_f
  end

  def test_it_can_find_total_revenue_for_a_single_merchant
    skip
    se = SalesEngine.from_csv({
      :merchants => "./data/merchants.csv",
      :invoice_items => "./data/invoice_items.csv",
      :invoices => "./data/invoices.csv",
      :transactions => "./data/transactions.csv"
        })
    sa = se.analyst

    assert_instance_of BigDecimal, sa.revenue_by_merchant(12334194)
    assert_equal 81572.4, sa.revenue_by_merchant(12334194).to_f
  end

  def test_it_can_return_top_merchants_by_revenue
    skip
    se = SalesEngine.from_csv({
      :merchants => "./data/merchants.csv",
      :invoice_items => "./data/invoice_items.csv",
      :invoices => "./data/invoices.csv",
      :transactions => "./data/transactions.csv"
        })
    sa = se.analyst
    assert_equal 12334634, sa.top_revenue_earners(10).first.id
    assert_equal 12335747, sa.top_revenue_earners(10).last.id
  end

  def test_it_can_return_top_merchants_by_revenue_defaults_to_20
    skip
    se = SalesEngine.from_csv({
      :merchants => "./data/merchants.csv",
      :invoice_items => "./data/invoice_items.csv",
      :invoices => "./data/invoices.csv",
      :transactions => "./data/transactions.csv"
        })
    sa = se.analyst
    assert_equal 20, sa.top_revenue_earners.length
  end

  def test_it_returns_merchants_with_pending_invoices
    skip
    se = SalesEngine.from_csv({
      :merchants => "./data/merchants.csv",
      :invoice_items => "./data/invoice_items.csv",
      :invoices => "./data/invoices.csv",
      :transactions => "./data/transactions.csv"
        })
    sa = se.analyst
    assert_equal 467, sa.merchants_with_pending_invoices.length
    assert_instance_of Merchant, sa.merchants_with_pending_invoices[0]
  end

  def test_it_can_return_merchants_with_one_item
    skip
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv"
        })
    sa = se.analyst
    assert_equal 243, sa.merchants_with_only_one_item.length
    assert_instance_of Merchant, sa.merchants_with_only_one_item[0]
  end

  def test_it_groups_merchants_with_invoice_items
    skip
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :invoices => "./data/invoices.csv",
      :merchants => "./data/merchants.csv",
      :invoice_items => "./data/invoice_items.csv",
      :transactions => "./data/transactions.csv"
        })
    sa = se.analyst
    assert_instance_of Merchant,
    sa.merchants_grouped_with_invoice_items.keys[0]
    assert_instance_of InvoiceItem, sa.merchants_grouped_with_invoice_items.values[0][0]
  end

  def test_it_can_return_merchants_with_one_item_registed_by_month
    skip
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :invoices => "./data/invoices.csv",
      :merchants => "./data/merchants.csv",
      :invoice_items => "./data/invoice_items.csv",
      :transactions => "./data/transactions.csv"
        })
    sa = se.analyst
    assert_equal 21, sa.merchants_with_only_one_item_registered_in_month("March").length
    assert_equal 18, sa.merchants_with_only_one_item_registered_in_month("June").length
  end

  def test_it_returns_most_sold_items_for_a_merchant
    skip
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :invoices => "./data/invoices.csv",
      :merchants => "./data/merchants.csv",
      :invoice_items => "./data/invoice_items.csv",
      :transactions => "./data/transactions.csv"
        })
    sa = se.analyst
    assert_instance_of Array, sa.most_sold_item_for_merchant(12334189)
    assert_instance_of Item, sa.most_sold_item_for_merchant(12334189)[0]
    assert_equal 263524984, sa.most_sold_item_for_merchant(12334189)[0].id
    assert_equal 263549386, sa.most_sold_item_for_merchant(12334768)[0].id
  end

  def test_it_returns_all_most_sold_items_for_a_merchant_when_tied
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :invoices => "./data/invoices.csv",
      :merchants => "./data/merchants.csv",
      :invoice_items => "./data/invoice_items.csv",
      :transactions => "./data/transactions.csv"
        })
    sa = se.analyst
    assert_instance_of Array, sa.most_sold_item_for_merchant(12337105)
    assert_instance_of Item, sa.most_sold_item_for_merchant(12337105)[0]
    assert_instance_of Item, sa.most_sold_item_for_merchant(12337105)[1]
    assert_equal 4, sa.most_sold_item_for_merchant(12337105).length
  end

  def test_it_returns_item_with_most_revenue_generated_by_merchant
    skip
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :invoices => "./data/invoices.csv",
      :merchants => "./data/merchants.csv",
      :invoice_items => "./data/invoice_items.csv",
      :transactions => "./data/transactions.csv"
        })
    sa = se.analyst
    assert_instance_of Item, sa.best_item_for_merchant(12334189)
    assert_equal 263516130, sa.best_item_for_merchant(12334189).id
    assert_instance_of Item, sa.best_item_for_merchant(12337105)
    assert_equal 263463003, sa.best_item_for_merchant(12337105).id
  end
end
