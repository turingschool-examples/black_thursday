require_relative 'test_helper'
require './lib/standard_deviation'
require './lib/analyst_helper'
require './lib/analyst_operations'

class AnalystHelperTest < Minitest::Test
  include AnalystHelper

  def setup
    se = SalesEngine.from_csv({
      :items     => "./fixtures/items_small_list.csv",
      :merchants => "./fixtures/merchant_small_list.csv",
      :invoices  => "./fixtures/invoices_small_list.csv"
    })
    @sa = SalesAnalyst.new(se)
  end

  def test_invoice_counts_counts_invoices
    assert_equal 0, @sa.invoice_counts.reduce(&:+)
  end

  def test_item_counts_counts_items
    assert_equal 2, @sa.item_counts.reduce(&:+)
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

end