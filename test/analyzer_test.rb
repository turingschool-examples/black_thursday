require_relative 'test_helper'
require_relative '../lib/analyzer'
require_relative '../lib/sales_engine'

# Analyzer Test class
class AnalyzerTest < Minitest::Test
  def setup
    sales_engine = SalesEngine.from_csv(
      customers: './test/fixtures/test_customers.csv',
      invoices: './test/fixtures/test_invoices.csv',
      invoice_items: './test/fixtures/test_invoice_items.csv',
      items: './test/fixtures/test_items1.csv',
      merchants: './test/fixtures/test_merchants1.csv',
      transactions: './test/fixtures/test_transactions.csv'
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

  def test_invoices_per_customer
    result = @analyzer.invoices_per_customer
    assert_instance_of Hash, result
  end

  def test_number_of_invoices_per_customer
    expected = {
      12335938 => 1,
      12334753 => 1,
      12334269 => 1,
      12335311 => 1,
      12334389 => 1,
      12335009 => 1,
      12337139 => 1,
      12336965 => 1,
      12334839 => 1,
      12335955 => 2,
      12334264 => 2,
      12334873 => 5
    }
    assert_equal expected, @analyzer.number_of_invoices_per_customer
  end

  def test_customers_per_count
    expected = {
      1 => [12335938,
            12334753,
            12334269,
            12335311,
            12334389,
            12335009,
            12337139,
            12336965,
            12334839],
      2 => [12335955, 12334264],
      5 => [12334873]
    }
    assert_equal expected, @analyzer.customers_per_count
  end
end
