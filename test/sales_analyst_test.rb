require 'simplecov'
SimpleCov.start

require 'minitest/autorun'
require 'minitest/pride'
require './lib/sales_analyst'
require './lib/sales_engine'
require 'pry'

class SalesAnalystTest < Minitest::Test
  def setup
    @csv_data = {
                  :items         => './data/items.csv',
                  :merchants     => './data/merchants.csv',
                  :invoices      => './data/invoices.csv',
                  :customers     => './data/customers.csv',
                  :transactions  => './data/transactions.csv',
                  :invoice_items => './data/invoice_items.csv'
                }
  end

  def test_it_exists_and_has_attributes
    engine = SalesEngine.from_csv(@csv_data)
    analyst = SalesAnalyst.new(engine)

    assert_instance_of SalesAnalyst, analyst
  end

  def test_it_can_find_all
    engine = SalesEngine.from_csv(@csv_data)
    analyst = SalesAnalyst.new(engine)

    assert_instance_of Array, analyst.items_per_merchant
    assert_equal 475, analyst.items_per_merchant.count
  end

  def test_it_can_give_average_items_per_merchant
    engine = SalesEngine.from_csv(@csv_data)
    analyst = SalesAnalyst.new(engine)

    assert_equal 2.88, analyst.average_items_per_merchant
  end

  def test_we_can_find_average_standard_deviation
    engine = SalesEngine.from_csv(@csv_data)
    analyst = SalesAnalyst.new(engine)

    assert_equal 3.26, analyst.average_items_per_merchant_standard_deviation
  end

  def test_merchants_with_high_item_count
    engine = SalesEngine.from_csv(@csv_data)
    analyst = SalesAnalyst.new(engine)

    assert_instance_of Array, analyst.merchants_with_high_item_count
    assert_equal 52, analyst.merchants_with_high_item_count.count
  end

  def test_average_item_price_for_merchant
    engine = SalesEngine.from_csv(@csv_data)
    analyst = SalesAnalyst.new(engine)

    assert_instance_of BigDecimal, analyst.average_item_price_for_merchant(12334159)
    assert_equal 0.315e2, analyst.average_item_price_for_merchant(12334159)
  end

  def test_it_can_find_average_average_price_per_merchants
    engine = SalesEngine.from_csv(@csv_data)
    analyst = SalesAnalyst.new(engine)

    assert_instance_of BigDecimal, analyst.average_average_price_per_merchant
    assert_equal 0.35029e3, analyst.average_average_price_per_merchant
  end

  def test_golden_items
    engine = SalesEngine.from_csv(@csv_data)
    analyst = SalesAnalyst.new(engine)

    assert_instance_of Array, analyst.golden_items
    assert_equal 5, analyst.golden_items.count
  end

  def test_average_price
    engine = SalesEngine.from_csv(@csv_data)
    analyst = SalesAnalyst.new(engine)

    assert_instance_of BigDecimal, analyst.average_price
    assert_equal 0.25106e3, analyst.average_price
  end

  def test_average_price_standard_deviation
    engine = SalesEngine.from_csv(@csv_data)
    analyst = SalesAnalyst.new(engine)

    assert_equal 0.290099e4, analyst.average_price_standard_deviation
  end

  def test_invoices_per_merchant
    engine = SalesEngine.from_csv(@csv_data)
    analyst = SalesAnalyst.new(engine)

    assert_equal 475, analyst.invoices_per_merchant.count
  end

  def test_average_invoices_per_merchant
    engine = SalesEngine.from_csv(@csv_data)
    analyst = SalesAnalyst.new(engine)

    assert_equal 10.49, analyst.average_invoices_per_merchant
  end

  def test_average_invoices_per_merchant_standard_deviation
    engine = SalesEngine.from_csv(@csv_data)
    analyst = SalesAnalyst.new(engine)

    assert_equal 3.29, analyst.average_invoices_per_merchant_standard_deviation
  end

  def test_top_merchants_by_invoice_count
    engine = SalesEngine.from_csv(@csv_data)
    analyst = SalesAnalyst.new(engine)

    assert_equal 12, analyst.top_merchants_by_invoice_count.count
  end

  def test_bottom_merchants_by_invoice_count
    engine = SalesEngine.from_csv(@csv_data)
    analyst = SalesAnalyst.new(engine)

    assert_equal 4, analyst.bottom_merchants_by_invoice_count.count
  end

  def test_top_days_by_invoice_count
    engine = SalesEngine.from_csv(@csv_data)
    analyst = SalesAnalyst.new(engine)

    assert_equal ["Wednesday"], analyst.top_days_by_invoice_count
  end

  def test_invoice_status
    engine = SalesEngine.from_csv(@csv_data)
    analyst = SalesAnalyst.new(engine)

    assert_equal 29.55, analyst.invoice_status(:pending)
    assert_equal 56.95, analyst.invoice_status(:shipped)
    assert_equal 13.5, analyst.invoice_status(:returned)
  end

  def test_it_can_return_invoices_per_day
    engine = SalesEngine.from_csv(@csv_data)
    analyst = SalesAnalyst.new(engine)

    days_of_the_week = [
                        "Saturday",
                        "Friday",
                        "Wednesday",
                        "Monday",
                        "Sunday",
                        "Tuesday",
                        "Thursday"
                       ]

    assert_instance_of Hash, analyst.invoices_per_day
    assert_equal days_of_the_week, analyst.invoices_per_day.keys
  end

  def test_it_can_return_average_invoices_per_day
    engine = SalesEngine.from_csv(@csv_data)
    analyst = SalesAnalyst.new(engine)

    assert_equal 712, analyst.average_invoices_per_day
  end

  def test_it_can_return_standard_deviation
    engine = SalesEngine.from_csv(@csv_data)
    analyst = SalesAnalyst.new(engine)

    assert_equal 18.06, analyst.average_invoices_per_day_standard_deviation
  end

  def test_invoice_paid_in_full_with_invoice_id_arg

    engine = SalesEngine.from_csv(@csv_data)
    analyst = SalesAnalyst.new(engine)

    assert_equal true, analyst.invoice_paid_in_full?(1)
    assert_equal false, analyst.invoice_paid_in_full?(3)
  end

  def test_invoice_total_with_invoice_id_arg
    engine = SalesEngine.from_csv(@csv_data)
    analyst = SalesAnalyst.new(engine)

    assert_nil analyst.invoice_total(100000000000)
    assert_equal 0.528913e4, analyst.invoice_total(2)
    assert_instance_of BigDecimal, analyst.invoice_total(2)

  end
end
