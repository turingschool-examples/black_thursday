require_relative "test_helper"
require_relative '../lib/sales_analyst'
require_relative '../lib/sales_engine'

class SalesAnalystTest < MiniTest::Test
  attr_reader :se,
              :sa

  def setup
    @se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoices  => "./data/invoices.csv"
    })

    @sa = SalesAnalyst.new(se)
  end

  def test_it_exists
    assert_instance_of SalesAnalyst, sa
    assert_instance_of SalesEngine, sa.se
    assert_instance_of MerchantRepository, sa.se.merchants
    assert_instance_of ItemRepository, sa.se.items
  end

  def test_can_calculate_average_items_per_merchant
    assert_equal 2.88, sa.average_items_per_merchant
  end

  def test_can_calculate_standard_deviation
    assert_equal 2.39, sa.standard_deviation([2,3,5,6,8])
  end

  def test_sa_can_calculate_standard_deviation_for_fixture
    assert_equal 0.58, sa.average_items_per_merchant_standard_deviation
  end

  def test_sa_can_calculate_standard_deviation_for_full_data_set
    assert_equal 3.26, sa.average_items_per_merchant_standard_deviation
  end

  def test_sa_can_find_merchants_that_sell_most_items
    se = SalesEngine.from_csv({
      :items     => "./test/fixtures/items_fixture.csv",
      :merchants => "./test/fixtures/merchants_fixture.csv",
      :invoices  => "./data/invoices.csv"
    })

    sa = SalesAnalyst.new(se)

    assert_instance_of Array, sa.merchants_with_high_item_count
    assert_instance_of Merchant, sa.merchants_with_high_item_count.first
    assert_equal 2, sa.merchants_with_high_item_count.count
  end

  def test_sa_can_find_average_item_price_for_individual_merchant
    se = SalesEngine.from_csv({
      :items     => "./test/fixtures/items_fixture.csv",
      :merchants => "./test/fixtures/merchants_fixture.csv",
      :invoices  => "./data/invoices.csv"
    })
    sa = SalesAnalyst.new(se)

    result = sa.average_item_price_for_merchant(12334112)

    assert_equal 0.55e-1, result
  end

  def test_sa_can_find_average_item_price_for_all_merchants
    se = SalesEngine.from_csv({
      :items     => "./test/fixtures/items_fixture.csv",
      :merchants => "./test/fixtures/merchants_fixture.csv",
      :invoices  => "./data/invoices.csv"
    })
    sa = SalesAnalyst.new(se)

    result = sa.average_average_price_per_merchant

    assert_equal "", result
  end

end
