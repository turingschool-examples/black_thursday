require_relative 'test_helper'
require './lib/standard_deviation'
require './lib/analyst_helper'
require './lib/analyst_operations'

class AnalystHelperTest < Minitest::Test

  def setup
    @se = SalesEngine.from_csv({
      :items => "./fixtures/items_small_list.csv",
      :invoices => "./fixtures/invoices_small_list.csv",
      :merchants => "./fixtures/merchant_small_list.csv",
      :invoice_items => "./fixtures/invoice_item_small_list.csv",
      :transactions => "./fixtures/transactions_small_list.csv",
      :customers => "./fixtures/customers_small_list.csv"
    })
    @sa = SalesAnalyst.new(@se)
  end

  def test_price_compiler_compiles_prices
    assert_equal 29.99, @sa.price_compiler(12334105)[0].to_f
  end

  def test_no_prices_returns_expected_value
    assert_equal [0], @sa.no_prices
  end

  def test_days_of_the_week_returns_proper_hash
    assert_equal ({"Saturday"=>2, "Friday"=>2, "Wednesday"=>1, "Monday"=>2}), @sa.days_of_the_week
  end

  def test_all_prices_retrieves_prices
    assert_equal Array, @sa.all_prices(@sa.merchants[0].items).class
    assert_equal 1, @sa.all_prices(@sa.merchants[0].items).size
    assert_equal BigDecimal, @sa.all_prices(@sa.merchants[0].items)[0].class
  end

  def test_big_performs_average
    assert_equal 3.0, @sa.big([2,3,4])
  end

  def test_single_detects_single_item_array
    assert_equal true, @sa.single([2])
  end

  def test_empty_detects_empty_array
    assert_equal false, @sa.empty([2])
  end

  def test_decimal_creates_big_decimal
    assert_equal BigDecimal, @sa.decimal(2).class
  end

end