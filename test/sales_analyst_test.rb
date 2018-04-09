require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/sales_analyst'

class SalesAnalystTest < Minitest::Test
  def test_exists
    se = SalesEngine.new({:items=> './test/items.csv',:merchants => './data/merchants.csv'})

    sales_analyst = SalesAnalyst.new(se)

    assert_instance_of SalesAnalyst, sales_analyst
  end

  def test_if_it_has_merchant_repo
    se = SalesEngine.new({:items=> "./test/items.csv",:merchants => "./data/merchants.csv"})

    sales_analyst = SalesAnalyst.new(se)

    assert_equal 'Shopin1901', sales_analyst.merchant_repo.merchants.first.name
    assert_equal 12334105, sales_analyst.merchant_repo.merchants.first.id
  end

  def test_if_it_has_items_repo
    se = SalesEngine.new({:items=> './test/items.csv',:merchants => './data/merchants.csv'})

    sales_analyst = SalesAnalyst.new(se)

    assert_equal  '510+ RealPush Icon Set', sales_analyst.item_repo.items.first.name
    assert_equal 263395237, sales_analyst.item_repo.items.first.id
  end

  def test_sales_analyst_can_find_total_no_of_items_in_item_repo
    se = SalesEngine.new({:items=> './test/items.csv',:merchants => './data/merchants.csv'})
    sales_analyst = SalesAnalyst.new(se)

    assert_equal 1367, sales_analyst.item_repo.items.count
  end

  def test_sales_analyst_can_find_total_no_of_items_in_item_repo
    se = SalesEngine.new({:items=> './test/items.csv',:merchants => './data/merchants.csv'})
    sales_analyst = SalesAnalyst.new(se)

    assert_equal 475, sales_analyst.merchant_repo.merchants.count
  end

  def test_it_can_find_average_items_per_merchants
    se = SalesEngine.new({:items=> './test/items.csv',:merchants => './data/merchants.csv'})
    sales_analyst = SalesAnalyst.new(se)

    assert_equal 2.88, sales_analyst.average_items_per_merchant
  end

  def test_it_can_count_calculate_average_items_per_merchant_standard_deviation
    se = SalesEngine.new ({:items => './data/items.csv',:merchants => './data/merchants.csv'})
    sales_analyst = SalesAnalyst.new(se)

    assert_equal 3.26, sales_analyst.average_items_per_merchant_standard_deviation
  end

  def test_it_can_calculate_merchants_with_high_item_count
    se = SalesEngine.new({:items=> './test/items.csv',:merchants => './data/merchants.csv'})
    sales_analyst = SalesAnalyst.new(se)

    assert_equal 52, sales_analyst.merchants_with_high_item_count.count
  end

  def test_it_can_calculate_average_item_price_for_merchant
    se = SalesEngine.new({:items=> './test/items.csv',:merchants => './data/merchants.csv'})
    sales_analyst = SalesAnalyst.new(se)

    assert_equal 16.66, sales_analyst.average_item_price_for_merchant(12334105)
  end

  def test_it_can_calculate_average_average_price_per_merchant
    se = SalesEngine.new({:items=> './test/items.csv',:merchants => './data/merchants.csv'})
    sales_analyst = SalesAnalyst.new(se)

    assert_equal 350.29, sales_analyst.average_average_price_per_merchant
  end

  def test_it_can_find_average_price_of_items
    se = SalesEngine.new({:items=> './test/items.csv',:merchants => './data/merchants.csv'})
    sales_analyst = SalesAnalyst.new(se)

    assert_equal 251.06, sales_analyst.average_price_of_items
  end

  def test_it_can_find_standard_deviation_for_item_price
    se = SalesEngine.new({:items=> './test/items.csv',:merchants => './data/merchants.csv'})
    sales_analyst = SalesAnalyst.new(se)

    assert_equal 2900.99, sales_analyst.standard_deviation_for_item_price
  end

  def test_it_can_find_golden_items
    se = SalesEngine.new({:items=> './test/items.csv',:merchants => './data/merchants.csv'})
    sales_analyst = SalesAnalyst.new(se)

    assert_equal 5, sales_analyst.golden_items.count
  end
end
