require_relative 'test_helper'
require_relative '../lib/analyzer'
require_relative '../lib/sales_engine'

# Analyzer Test class
class AnalyzerTest < Minitest::Test
  
  def setup
    sales_engine = SalesEngine.from_csv(
      invoices: './test/fixtures/test_invoices.csv',
      items: './test/fixtures/test_items1.csv',
      merchants: './test/fixtures/test_merchants1.csv'
    )
    @analyzer = Analyzer.new(sales_engine)
  end

  def test_average
    assert_equal 2, @analyzer.average(4, 2)
  end

  def test_standard_deviation
    set = [3, 4, 5]
    assert_equal 1, @analyzer.standard_deviation(set, @analyzer.average(set.reduce(:+), set.count))
  end

  def test_number_of_merchants
    assert_equal 5, @analyzer.number_of_merchants
  end

  def test_number_of_items
    assert_equal 14, @analyzer.number_of_items
  end

  def test_number_of_items_per_merchant
    skip
    expected = { 12335938=>1,
                 12334753=>1,
                 12335955=>1,
                 12334269=>1,
                 12335311=>1,
                 12334389=>1,
                 12335009=>1,
                 12337139=>1,
                 12336965=>1,
                 12334839=>1,
                 12334264=>1,
                 12334873=>1 }
    assert_equal expected, @analyzer.items_per_merchant
  end

  def test_items_per_merchant
    result = @analyzer.items_per_merchant
    assert(result.all? { |_id, items| items.class == Array })
    assert_instance_of Item, result.values[0][0]
    assert_instance_of Item, result.values[-1][-1]
  end
end
