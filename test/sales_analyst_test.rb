require 'simplecov'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/sales_analyst'
require './lib/sales_engine'

class SalesAnalystTest < Minitest::Test

  def setup
    @sales_engine  = SalesEngine.from_csv({:items    => "./data/items.csv",
                                    :merchants     => "./data/merchants.csv",
                                    :invoices      => "./data/invoices.csv",
                                    :invoice_items => "./data/invoice_items.csv",
                                    :transactions => "./data/transactions.csv"
                                    # :customer => "./data/customers.cvs"
                                    })
    @sales_analyst = SalesAnalyst.new(@sales_engine)
  end

  def test_it_exists
    assert_instance_of SalesAnalyst, @sales_analyst
  end

  def test_it_has_an_engine
    assert_instance_of SalesEngine, @sales_analyst.engine
  end

  def test_it_can_find_average_items_per_merchant
    assert_equal 2.88, @sales_analyst.average_items_per_merchant
  end

  def test_it_can_find_standard_deviation
    assert_equal 3.26, @sales_analyst.average_items_per_merchant_standard_deviation
  end

  def test_it_can_return_items_each_merchant
    merchant_items = @sales_analyst.array_of_items_by_merchant

    assert_instance_of Array, merchant_items
    assert_equal 3, merchant_items[0]
    assert_equal 7, merchant_items[10]
  end

  def test_it_can_return_high_item_merchants
    high_item_merchants = @sales_analyst.merchants_with_high_item_count

    assert_instance_of Array, high_item_merchants
    assert_equal 52, high_item_merchants.length
  end

  def test_it_can_find_the_average_item_price_for_a_merchant
    merchant_price_average = @sales_analyst.average_item_price_for_merchant(12334105)

    assert_instance_of BigDecimal, merchant_price_average
    assert_equal 16.66, merchant_price_average.to_f
  end

  def test_it_can_find_the_average_of_average_prices
    average_of_averages = @sales_analyst.average_average_price_per_merchant

    assert_instance_of BigDecimal, average_of_averages
    assert_equal 350.29, average_of_averages.to_f
  end

  def test_it_can_average_item_price
    average_price_of_items = @sales_analyst.average_item_price

    assert_instance_of BigDecimal, average_price_of_items
    assert_equal 251.06, average_price_of_items.to_f
  end

  def test_it_can_find_average_item_price_standard_deviation
    average_standard_deviation = @sales_analyst.average_item_price_standard_deviation

    assert_instance_of Float, average_standard_deviation
    assert_equal 2900.99, average_standard_deviation
  end

  def test_it_can_find_golden_items
    golden_items = @sales_analyst.golden_items

    assert_instance_of Array, golden_items
    assert_instance_of Item, golden_items[0]
    assert_equal 5, golden_items.length
  end

  def test_it_can_find_average_invoices
    assert_equal 10.49, @sales_analyst.average_invoices_per_merchant
  end

  def test_it_can_find_invoice_standard_deviation
    assert_equal 3.29, @sales_analyst.average_invoices_per_merchant_standard_deviation
  end

  def test_it_can_return_items_each_merchant
    invoices = @sales_analyst.array_of_invoices_by_merchant

    assert_instance_of Array, invoices
    assert_equal 10, invoices[0]
    assert_equal 20, invoices[10]
  end

  def test_it_can_find_merchants_with_top_invoice_number
    merchants = @sales_analyst.top_merchants_by_invoice_count

    assert_instance_of Merchant, merchants[0]
    assert_equal 12, merchants.length
  end

  def test_it_can_find_merchants_with_top_invoice_number
    merchants = @sales_analyst.bottom_merchants_by_invoice_count

    assert_instance_of Merchant, merchants[0]
    assert_equal 4, merchants.length
  end

  def test_it_can_find_top_days_by_invoices
    top_days = @sales_analyst.top_days_by_invoice_count

    assert_instance_of Array, top_days
    assert_equal 1, top_days.length
    assert_equal 'Wednesday', top_days[0]
  end

  def test_it_can_calculate_status_percentage
    pending  = @sales_analyst.invoice_status(:pending)
    shipped  = @sales_analyst.invoice_status(:shipped)
    returned = @sales_analyst.invoice_status(:returned)

    assert_equal 29.55, pending
    assert_equal 56.95, shipped
    assert_equal 13.5, returned
  end


end
