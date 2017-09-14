require_relative 'test_helper'
require_relative '../lib/sales_analyst'
require_relative '../lib/sales_engine'

class SalesAnalystTest < Minitest::Test
  attr_reader :se, 
              :sa, 
              :fe, 
              :fa
  
  def setup
    @se = SalesEngine.from_csv({ :items     => "./data/items.csv",
                                 :merchants => "./data/merchants.csv",
                                 :invoices  => "./data/invoices.csv"})
    @sa = SalesAnalyst.new(se)
    @fe = SalesEngine.from_csv({ :items     => "./test/fixtures/items.csv",
                                 :merchants => "./data/merchants.csv",
                                 :invoices  => "./test/fixtures/invoices.csv"})

    @fa = SalesAnalyst.new(fe)                   
  end

  def test_that_it_exists
    assert_instance_of SalesAnalyst, sa
    assert_instance_of SalesAnalyst, fa
  end

  def test_average_items_per_merchant_spec
    expected = sa.average_items_per_merchant

    assert_equal 2.88, expected
    assert_instance_of Float, expected
  end
  
  def test_average_items_per_merchant_fixture 
    expected = fa.average_items_per_merchant

    assert_equal 0.12, expected
    assert_instance_of Float, expected
  end

  def test_it_returns_standard_deviation_spec
    expected = sa.average_items_per_merchant_standard_deviation

    assert_equal 3.26, expected
    assert_instance_of Float, expected
  end

  def test_it_returns_standard_deviation_fixture
    expected = fa.average_items_per_merchant_standard_deviation

    assert_equal 0.71, expected
    assert_instance_of Float, expected
  end

  def test_merchants_with_high_item_count_spec
    expected = sa.merchants_with_high_item_count

    assert_equal 52, expected.length
    assert_instance_of Merchant, expected.first
  end

  def test_merchants_with_high_item_count_fixture
    expected = fa.merchants_with_high_item_count

    assert_equal 30, expected.length
    assert_instance_of Merchant, expected.first
  end

  def test_average_item_price_for_merchant_spec
    merchant_id = 12334105
    expected = sa.average_item_price_for_merchant(merchant_id)

    assert_equal 16.66, expected
    assert_instance_of BigDecimal, expected
  end

  def test_average_item_price_for_merchant_fixture
    merchant_id = 12334105
    expected = fa.average_item_price_for_merchant(merchant_id)

    assert_equal 29.99, expected
    assert_instance_of BigDecimal, expected
  end

  def test_average_average_price_per_merchant_spec
    expected = sa.average_average_price_per_merchant

    assert_equal 350.29, expected
    assert_instance_of BigDecimal, expected
  end

  def test_golden_items_returns_above_average_items
    expected = sa.golden_items
  
    assert_equal 5, expected.length
    assert_instance_of Item, expected.first
  end

  def test_golden_items_returns_above_average_items_fixture
    expected = fa.golden_items
  
    assert_equal 1, expected.length
    assert_instance_of Item, expected.first
  end

  def test_average_invoices_per_merchant 
    expected = sa.average_invoices_per_merchant

    assert_equal 10.49, expected
    assert_instance_of Float, expected
  end

  def test_average_invoices_per_merchant_fixture 
    expected = fa.average_invoices_per_merchant

    assert_equal 1.05, expected
    assert_instance_of Float, expected
  end

  def test_average_invoices_per_merchant_standard_deviation 
    expected = sa.average_invoices_per_merchant_standard_deviation

    assert_equal 3.29, expected 
    assert_instance_of Float, expected 
  end

  def test_average_invoices_per_merchant_standard_deviation_fixture 
    expected = fa.average_invoices_per_merchant_standard_deviation

    assert_equal 1.01, expected 
    assert_instance_of Float, expected 
  end

  def test_top_merchants_by_invoice_count
    skip # works but takes forever.  
    expected = sa.top_merchants_by_invoice_count

    assert_equal 12, expected.length
    assert_instance_of Array, expected
    assert_instance_of Merchant, expected.first
  end

  def test_top_merchants_by_invoice_count_fixture
    expected = fa.top_merchants_by_invoice_count

    assert_equal 10, expected.length
    assert_instance_of Array, expected
    assert_instance_of Merchant, expected.first
  end

  def test_bottom_merchants_by_invoice_count 
    skip # works but takes forever.
    expected = sa.bottom_merchants_by_invoice_count

    assert_equal 4, expected.length
    assert_instance_of Array, expected
    assert_instance_of Merchant, expected.first
  end

  def test_bottom_merchants_by_invoice_count_fixture
    expected = fa.bottom_merchants_by_invoice_count

    assert_equal 0, expected.length
    assert_instance_of Array, expected
  end
end