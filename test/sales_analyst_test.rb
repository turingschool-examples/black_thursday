require './test/test_helper.rb'
require './lib/sales_analyst'
require './lib/sales_engine'

class SalesAnalystTest < MiniTest::Test
  def setup
    se = SalesEngine.new({
      items:     './test/fixtures/items_truncated.csv',
      merchants: './test/fixtures/merchants_truncated.csv'
    })
    @sa = SalesAnalyst.new(se)
  end

  def test_it_finds_all_the_merchants
    result = @sa.merchants
    assert_equal 8, result.count
  end

  def test_it_finds_the_number_of_items_for_each_merchant
    assert_equal [3, 1, 1, 1, 3, 1, 1, 1], @sa.items_per_merchant
  end

  def test_it_finds_average_items_per_merchant
    assert_equal 1.5, @sa.average_items_per_merchant
  end

  def test_it_finds_the_total_number_of_items
    assert_equal 12, @sa.total_items
  end

  def test_it_finds_the_average_items_per_merchant_standard_deviation
    assert_equal 0.7385489458759964, @sa.average_items_per_merchant_standard_deviation
  end
end
