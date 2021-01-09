require 'simplecov'
SimpleCov.start

require 'minitest/autorun'
require 'minitest/pride'
require './lib/sales_analyst'
require './lib/sales_engine'
require 'pry'

class SalesAnalystTest < Minitest::Test
  def test_it_exists_and_has_attributes
    engine = SalesEngine.from_csv({
                                    :items     => "./data/items.csv",
                                    :merchants => "./data/merchants.csv",
                                    :invoices => "./data/invoices.csv",
                                    :customers  => "./data/customers.csv",
                                  })
    analyst = SalesAnalyst.new(engine)

    assert_instance_of SalesAnalyst, analyst
  end

  def test_it_can_find_all
    engine = SalesEngine.from_csv({
                                    :items     => "./data/items.csv",
                                    :merchants => "./data/merchants.csv",
                                    :invoices => "./data/invoices.csv",
                                    :customers  => "./data/customers.csv",
                                  })
    analyst = SalesAnalyst.new(engine)

    assert_instance_of Array, analyst.items_per_merchant
    assert_equal 475, analyst.items_per_merchant.count
  end

  def test_it_can_give_average_items_per_merchant
    engine = SalesEngine.from_csv({
                                    :items     => "./data/items.csv",
                                    :merchants => "./data/merchants.csv",
                                    :invoices => "./data/invoices.csv",
                                    :customers  => "./data/customers.csv",
                                  })
    analyst = SalesAnalyst.new(engine)

    assert_equal 2.88, analyst.average_items_per_merchant
  end

  def test_we_can_find_average_standard_deviation
    engine = SalesEngine.from_csv({
                                    :items     => "./data/items.csv",
                                    :merchants => "./data/merchants.csv",
                                    :invoices => "./data/invoices.csv",
                                    :customers  => "./data/customers.csv",
                                  })
    analyst = SalesAnalyst.new(engine)

    assert_equal 3.26, analyst.average_items_per_merchant_standard_deviation
  end

  def test_merchants_with_high_item_count
    engine = SalesEngine.from_csv({
                                    :items     => "./data/items.csv",
                                    :merchants => "./data/merchants.csv",
                                    :invoices => "./data/invoices.csv",
                                    :customers  => "./data/customers.csv",
                                  })
    analyst = SalesAnalyst.new(engine)

    assert_instance_of Array, analyst.merchants_with_high_item_count
    assert_equal 52, analyst.merchants_with_high_item_count.count
  end

  def test_average_item_price_for_merchant
    engine = SalesEngine.from_csv({
                                    :items     => "./data/items.csv",
                                    :merchants => "./data/merchants.csv",
                                    :invoices => "./data/invoices.csv",
                                    :customers  => "./data/customers.csv",
                                  })
    analyst = SalesAnalyst.new(engine)

    assert_instance_of BigDecimal, analyst.average_item_price_for_merchant(12334159)
    assert_equal 0.315e2, analyst.average_item_price_for_merchant(12334159)
  end

  def test_it_can_find_average_average_price_per_merchants
    skip
    engine = SalesEngine.from_csv({
                                    :items     => "./data/items.csv",
                                    :merchants => "./data/merchants.csv",
                                    :invoices => "./data/invoices.csv",
                                    :customers  => "./data/customers.csv",
                                  })
    analyst = SalesAnalyst.new(engine)

    assert_instance_of BigDecimal, analyst.average_average_price_per_merchant
    assert_equal 0.35029e3, analyst.average_average_price_per_merchant
  end

  def test_golden_items
    skip
    engine = SalesEngine.from_csv({
                                    :items     => "./data/items.csv",
                                    :merchants => "./data/merchants.csv",
                                    :invoices => "./data/invoices.csv",
                                    :customers  => "./data/customers.csv",
                                  })
    analyst = SalesAnalyst.new(engine)

    assert_instance_of Array, analyst.golden_items
    assert_equal 5, analyst.golden_items.count
  end

  def test_average_price
    skip
    engine = SalesEngine.from_csv({
                                    :items     => "./data/items.csv",
                                    :merchants => "./data/merchants.csv",
                                    :invoices => "./data/invoices.csv",
                                    :customers  => "./data/customers.csv",
                                  })
    analyst = SalesAnalyst.new(engine)

    assert_instance_of BigDecimal, analyst.average_price
    assert_equal 0.25106e3, analyst.average_price
  end

  def test_average_price_standard_deviation
    skip
    engine = SalesEngine.from_csv({
                                    :items     => "./data/items.csv",
                                    :merchants => "./data/merchants.csv",
                                    :invoices => "./data/invoices.csv",
                                    :customers  => "./data/customers.csv",
                                  })
    analyst = SalesAnalyst.new(engine)

    assert_equal 0.290099e4, analyst.average_price_standard_deviation
  end

  def test_invoices_per_merchant
    skip
    engine = SalesEngine.from_csv({
                                    :items     => "./data/items.csv",
                                    :merchants => "./data/merchants.csv",
                                    :invoices => "./data/invoices.csv",
                                    :customers  => "./data/customers.csv",
                                  })
    analyst = SalesAnalyst.new(engine)

    assert_equal 4985, analyst.invoices_per_merchant.count
  end

  def test_average_invoices_per_merchant
    skip
    engine = SalesEngine.from_csv({
                                    :items     => "./data/items.csv",
                                    :merchants => "./data/merchants.csv",
                                    :invoices => "./data/invoices.csv",
                                    :customers  => "./data/customers.csv",
                                  })
    analyst = SalesAnalyst.new(engine)

    assert_equal 10.49, analyst.average_invoices_per_merchant
  end

  def test_average_invoices_per_merchant_standard_deviation
    skip
    engine = SalesEngine.from_csv({
                                    :items     => "./data/items.csv",
                                    :merchants => "./data/merchants.csv",
                                    :invoices => "./data/invoices.csv",
                                    :customers  => "./data/customers.csv",
                                  })
    analyst = SalesAnalyst.new(engine)

    assert_equal 3.29, analyst.average_invoices_per_merchant_standard_deviation
  end

  def test_top_merchants_by_invoice_count
    engine = SalesEngine.from_csv({
                                    :items     => "./data/items.csv",
                                    :merchants => "./data/merchants.csv",
                                    :invoices => "./data/invoices.csv",
                                    :customers  => "./data/customers.csv",
                                  })
    analyst = SalesAnalyst.new(engine)

    assert_equal 12, analyst.top_merchants_by_invoice_count.count
  end

  # Who are our lowest performing merchants?
  # Which merchants are more than two standard deviations below the mean?
  def test_bottom_merchants_by_invoice_count
    skip
    engine = SalesEngine.from_csv({
                                    :items     => "./data/items.csv",
                                    :merchants => "./data/merchants.csv",
                                    :invoices => "./data/invoices.csv",
                                    :customers  => "./data/customers.csv",
                                  })
    analyst = SalesAnalyst.new(engine)

    assert_equal [merchant, merchant, merchant], analyst.bottom_merchants_by_invoice_count
  end

  # Which days of the week see the most sales?
  # On which days are invoices created at more than one standard deviation above the mean?
  def test_top_days_by_invoice_count
    engine = SalesEngine.from_csv({
                                    :items     => "./data/items.csv",
                                    :merchants => "./data/merchants.csv",
                                    :invoices => "./data/invoices.csv",
                                    :customers  => "./data/customers.csv",
                                  })
    analyst = SalesAnalyst.new(engine)

    assert_equal ["Wednesday"], analyst.top_days_by_invoice_count
  end

  # What percentage of invoices are not shipped?
  # What percentage of invoices are shipped vs pending vs returned? (takes symbol as argument)

  def test_invoice_status
    engine = SalesEngine.from_csv({
                                    :items     => "./data/items.csv",
                                    :merchants => "./data/merchants.csv",
                                    :invoices => "./data/invoices.csv",
                                    :customers  => "./data/customers.csv",
                                  })
    analyst = SalesAnalyst.new(engine)

    assert_equal 29.55, analyst.invoice_status(:pending)
    assert_equal 56.95, analyst.invoice_status(:shipped)
    assert_equal 13.5, analyst.invoice_status(:returned)
  end
end
