require_relative 'test_helper.rb'
require_relative '../lib/sales_analyst'
require_relative '../lib/sales_engine'

class SalesAnalystTest < MiniTest::Test
  def setup
    se = SalesEngine.from_csv({
      items:     './test/fixtures/items_truncated.csv',
      merchants: './test/fixtures/merchants_truncated.csv'
    })
    @sa = SalesAnalyst.new(se)
  end

  def test_it_finds_all_the_merchants
    merchants = @sa.merchants
    assert_equal 11, merchants.count
  end

  def test_it_finds_average_items_per_merchant
    assert_equal 1.64, @sa.average_items_per_merchant
  end

  def test_it_finds_the_total_number_of_items
    assert_equal 18, @sa.total_items
  end

  def test_it_finds_the_average_items_per_merchant_standard_deviation
    assert_equal 1.12, @sa.average_items_per_merchant_standard_deviation
  end

  def test_it_finds_the_merchants_with_the_highest_item_counts
    merchants = @sa.merchants_with_high_item_count

    assert_equal 3, merchants.count
  end
end

# time to run test: 0.021840s
