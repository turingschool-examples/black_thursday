require_relative 'test_helper'
require_relative '../lib/sales_analyst'
require_relative '../lib/sales_engine'

class SalesAnalystTest < Minitest::Test
  attr_reader :se,
              :sa,
              :fe,
              :fa

  def setup
    @se = SalesEngine.from_csv({  :items         => "./data/items.csv",
                                  :merchants     => "./data/merchants.csv",
                                  :invoices      => "./data/invoices.csv",
                                  :invoice_items => "./data/invoice_items.csv",
                                  :transactions  => "./data/transactions.csv",
                                  :customers     => "./data/customers.csv"
                                })
    @sa = SalesAnalyst.new(se)

    @fe = SalesEngine.from_csv({ :items         => "./test/fixtures/items.csv",
                                 :merchants     => "./data/merchants.csv",
                                 :invoices      => "./test/fixtures/invoices.csv",
                                 :customers     => "./data/customers.csv",
                                 :invoice_items => "./test/fixtures/invoice_items.csv",
                                 :transactions  => "./test/fixtures/transactions.csv"
                                })

    @fa = SalesAnalyst.new(fe)
  end

  def test_that_it_exists
    assert_instance_of SalesAnalyst, sa
    assert_instance_of SalesAnalyst, fa
  end

  def test_average_items_per_merchant_spec
    expected = sa.average_items_per_merchant

    assert_equal 2.88, expected
    assert_instance_of Float, expected
  end

  def test_average_items_per_merchant_fixture
    expected = fa.average_items_per_merchant

    assert_equal 0.12, expected
    assert_instance_of Float, expected
  end

  def test_it_returns_standard_deviation_spec
    expected = sa.average_items_per_merchant_standard_deviation

    assert_equal 3.26, expected
    assert_instance_of Float, expected
  end

  def test_it_returns_standard_deviation_fixture
    expected = fa.average_items_per_merchant_standard_deviation

    assert_equal 0.71, expected
    assert_instance_of Float, expected
  end

  def test_merchants_with_high_item_count_spec
    expected = sa.merchants_with_high_item_count

    assert_equal 52, expected.length
    assert_instance_of Merchant, expected.first
  end

  def test_merchants_with_high_item_count_fixture
    expected = fa.merchants_with_high_item_count

    assert_equal 30, expected.length
    assert_instance_of Merchant, expected.first
  end

  def test_average_item_price_for_merchant_spec
    merchant_id = 12334105
    expected = sa.average_item_price_for_merchant(merchant_id)

    assert_equal 16.66, expected
    assert_instance_of BigDecimal, expected
  end

  def test_average_item_price_for_merchant_fixture
    merchant_id = 12334105
    expected = fa.average_item_price_for_merchant(merchant_id)

    assert_equal 29.99, expected
    assert_instance_of BigDecimal, expected
  end

  def test_average_average_price_per_merchant_spec
    expected = sa.average_average_price_per_merchant

    assert_equal 350.29, expected
    assert_instance_of BigDecimal, expected
  end

  def test_golden_items_returns_above_average_items
    expected = sa.golden_items

    assert_equal 5, expected.length
    assert_instance_of Item, expected.first
  end

  def test_golden_items_returns_above_average_items_fixture
    expected = fa.golden_items

    assert_equal 1, expected.length
    assert_instance_of Item, expected.first
  end

  def test_average_invoices_per_merchant
    expected = sa.average_invoices_per_merchant

    assert_equal 10.49, expected
    assert_instance_of Float, expected
  end

  def test_average_invoices_per_merchant_fixture
    expected = fa.average_invoices_per_merchant

    assert_equal 1.05, expected
    assert_instance_of Float, expected
  end

  def test_average_invoices_per_merchant_standard_deviation
    expected = sa.average_invoices_per_merchant_standard_deviation

    assert_equal 3.29, expected
    assert_instance_of Float, expected
  end

  def test_average_invoices_per_merchant_standard_deviation_fixture
    expected = fa.average_invoices_per_merchant_standard_deviation

    assert_equal 1.01, expected
    assert_instance_of Float, expected
  end

  def test_top_merchants_by_invoice_count
    expected = sa.top_merchants_by_invoice_count

    assert_equal 12, expected.length
    assert_instance_of Array, expected
    assert_instance_of Merchant, expected.first
  end

  def test_top_merchants_by_invoice_count_fixture
    expected = fa.top_merchants_by_invoice_count

    assert_equal 10, expected.length
    assert_instance_of Array, expected
    assert_instance_of Merchant, expected.first
  end

  def test_bottom_merchants_by_invoice_count
    expected = sa.bottom_merchants_by_invoice_count

    assert_equal 4, expected.length
    assert_instance_of Array, expected
    assert_instance_of Merchant, expected.first
  end

  def test_bottom_merchants_by_invoice_count_fixture
    expected = fa.bottom_merchants_by_invoice_count

    assert_equal 0, expected.length
    assert_instance_of Array, expected
  end

  def test_invoice_count_returns_days_with_high_invoices
    expected = sa.top_days_by_invoice_count
    assert_equal 1, expected.length
    assert_equal "Wednesday", expected.first
    assert_instance_of String, expected.first
  end

  def test_invoice_std_deviation
    invoices_per_day = [1, 2, 3, 4, 5, 6, 7]
    expected = sa.invoice_std_deviation(invoices_per_day)

    assert_equal 708, expected
  end

  def test_invoices_per_day
    expected = [729, 701, 741, 696, 708, 692, 718]
    assert_equal expected, sa.invoices_per_day
  end

  def test_day_array
    actual   = sa.day_array
    expected = [["Saturday", 729],
                ["Friday", 701],
                ["Wednesday", 741],
                ["Monday", 696],
                ["Sunday", 708],
                ["Tuesday", 692],
                ["Thursday", 718]]

    assert_equal expected, actual
  end

  def test_days_with_high_invoices
    arg1     = sa.day_array
    arg2     = sa.avg_inv_per_day
    arg3     = sa.invoice_std_deviation(sa.invoices_per_day)
    expected = sa.days_with_high_invoices(arg1, arg2, arg3)

    assert_equal 'Wednesday', expected[0]
  end

  def test_grouped_invoices
    assert_instance_of Hash, sa.grouped_invoices
  end

  def test_avg_inv_per_day
    assert_equal 712, sa.avg_inv_per_day
  end

  def test_invoice_status_returns_percentage_of_given_status
    expected = sa.invoice_status(:pending)
    assert_equal 29.55, expected

    expected = sa.invoice_status(:shipped)
    assert_equal 56.95, expected

    expected = sa.invoice_status(:returned)
    assert_equal 13.5, expected
  end


  def test_invoice_is_paid_in_full_returns_bool
    expected_1 = sa.engine.invoices.find_by_id(1).is_paid_in_full?
    expected_2 = sa.engine.invoices.find_by_id(200).is_paid_in_full?
    expected_3 = sa.engine.invoices.find_by_id(203).is_paid_in_full?
    expected_4 = sa.engine.invoices.find_by_id(204).is_paid_in_full?

    assert expected_1
    assert expected_2
    refute expected_3
    refute expected_4
  end

  def test_invoice_total_returns_total_if_paid_in_full
    invoice  = sa.engine.invoices.all.first
    expected = invoice.total

    assert invoice.is_paid_in_full?
    assert_equal 21067.77, expected
    assert_instance_of BigDecimal, expected
  end

  def test_invoice_total_returns_0_if_not_paid_in_full
    invoice  = sa.engine.invoices.find_by_id(204)
    expected = invoice.total

    assert_equal 0, expected
  end

  def test_total_revenue_by_date_returns_total_revenue_for_given_date
    date = Time.parse("2009-02-07")
    expected = sa.total_revenue_by_date(date)

    assert_equal 21067.77, expected
    assert_instance_of BigDecimal, expected
  end

  def test_total_revenue_by_date_returns_total_revenue_for_other_given_date
    date = Time.parse("2008-09-21")
    expected = sa.total_revenue_by_date(date)

    assert_equal 41211.16, expected
    assert_instance_of BigDecimal, expected
  end

  def test_top_revenue_earners_returns_top_x_merchants_ranked_by_revenue
    expected = sa.top_revenue_earners(10)
    first    = expected.first
    last     = expected.last

    assert_equal 10, expected.length

    assert_instance_of Merchant, expected.first
    assert_equal 12334634, expected.first.id
  end

  def test_top_revenue_earners_returns_20_merchants_by_default
    expected = sa.top_revenue_earners
    first    = expected.first
    last     = expected.last

    assert_equal 20, expected.length
    assert_equal 12334634, first.id
    assert_equal 12334159, last.id
    assert_instance_of Merchant, expected.first
    assert_instance_of Merchant, last
  end

  def test_merchants_ranked_by_revenue
    expected = sa.merchants_ranked_by_revenue

    assert_instance_of Merchant, expected.first
    assert_equal 12334634, expected.first.id 
    assert_equal 12336175, expected.last.id
  end

  def test_merchants_with_pending_invoices 
    expected = sa.merchants_with_pending_invoices

    assert_equal 467, expected.length 
    assert_instance_of Merchant, expected.first    
  end

  def test_merchants_with_only_one_item 
    expected = sa.merchants_with_only_one_item

    assert_equal 243, expected.length 
    assert_instance_of Merchant, expected.first        
  end
end