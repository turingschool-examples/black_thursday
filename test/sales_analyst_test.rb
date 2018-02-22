require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/sales_analyst'
require_relative '../lib/sales_engine'
require_relative 'mocks/test_engine'

class SalesAnalystTest < Minitest::Test
  def setup
    @sa = SalesAnalyst.new MOCK_SALES_ENGINE
  end

  def test_does_create_sales_analyst
    assert_instance_of SalesAnalyst, @sa
  end

  def test_does_have_sales_engine
    assert_instance_of SalesEngine, @sa.sales_engine
  end

  def test_can_calculate_average_item_cost
    assert_equal Rational(95.0 / 4.0), @sa.average_item_cost
  end

  def test_can_calculate_item_cost_standard_deviation
    assert_equal Math.sqrt(Rational(79.0 / 14.0)) * 5,
                 @sa.item_cost_standard_deviation
  end

  def test_can_find_golden_items
    items = @sa.golden_items
    assert_instance_of Array, items
    assert_equal 1, items.length
    assert_equal 'Item E', items.first.name
  end

  def test_does_get_merchants_with_high_item_count
    merchants = @sa.merchants_with_high_item_count

    assert_instance_of Array, merchants
    assert_equal 2, merchants.length
    merchants.each do |merchant|
      assert_instance_of Merchant, merchant
    end
    assert_equal 3, merchants.first.id
    assert_equal 7, merchants[1].id
  end

  def test_does_get_average_item_merchant_price
    assert_equal 35.0, @sa.average_item_price_for_merchant(7)
    assert_equal 0, @sa.average_item_price_for_merchant(9)
  end

  def test_can_get_average_price_for_all_merchants
    assert_equal Rational(115.0 / 9.0).to_f.round(2),
                 @sa.average_average_price_per_merchant
  end

  def test_can_get_average_items_for_merchant
    assert_equal (8 / 9.0).round(2),
                 @sa.average_items_per_merchant
  end

  def test_it_can_standard_deviate_average_items_per_merchant
    assert_equal (Math.sqrt(10) / 3).round(2),
                 @sa.average_items_per_merchant_standard_deviation
  end

  def test_it_can_get_top_merchants_by_invoice_count
    merchants = @sa.top_merchants_by_invoice_count
    assert_instance_of Array, merchants
    assert_equal 1, merchants.length
    assert_equal 4, merchants.first.id
  end

  def test_it_can_get_bottom_merchants_by_invoice_count
    merchants = @sa.bottom_merchants_by_invoice_count
    assert_instance_of Array, merchants
    assert_equal 1, merchants.length
    assert_equal 9, merchants.first.id
  end
end
