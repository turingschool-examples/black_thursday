require_relative 'test_helper'
require_relative '../lib/sales_analyst'

class SalesAnalystTest < Minitest::Test

  def setup
    se = SalesEngine.from_csv({:items => "./data/items_fixture.csv", :merchants => "./data/merchants_fixture.csv", :invoices => "./data/invoices_fixture.csv", })
    @sa = SalesAnalyst.new(se)    
  end

  def test_it_exists
    
    sa = SalesAnalyst.new(@se)
    assert_instance_of SalesAnalyst, sa
  end  

  def test_that_average_items_per_merchant
    assert_equal 2.18, @sa.average_items_per_merchant
  end

  def test_standard_deviation
    collection = [1, 2, 3, 4, 5, 6, 7]
    assert_equal 2.16, @sa.standard_deviation(collection)
  end

  def test_sampled_average_items_per_merchant_standard_deviation
    assert_equal 3.0, @sa.average_items_per_merchant_standard_deviation
  end

# Delete this? SD should always use all merchants 
  def test_population_average_items_per_merchant_standard_deviation
    # skip
    se = SalesEngine.from_csv({:items => "./data/items.csv", :merchants => "./data/merchants.csv" })
    sa = SalesAnalyst.new(se)
    # binding.pry
    assert_equal 3.26, sa.average_items_per_merchant_standard_deviation
  end


  def test_merchants_with_high_item_count
    high_count = @sa.merchants_with_high_item_count
    assert_instance_of Array, high_count 
    assert_equal "Uniford", high_count[0].name
  end

  def test_average_item_price_for_merchant
    assert_instance_of BigDecimal, @sa.average_item_price_for_merchant(12334174) 
    assert_equal 9.85, @sa.average_item_price_for_merchant(12334174) 
  end


  def test_average_of_average_price
    se = SalesEngine.from_csv({:items => "./data/items_fixture.csv", :merchants => "./data/merchants_fixture.csv" })
    sa = SalesAnalyst.new(se)
    assert_instance_of BigDecimal, sa.average_average_price_per_merchant
    assert_equal 37.01, sa.average_average_price_per_merchant
  end

  def test_golden_items
    golden = @sa.golden_items
    assert_instance_of Array, golden
    assert_instance_of Item, golden[0]
    assert_equal "Peanut", golden[0].name
    assert_equal "Crown jewels", golden[1].name
    assert_equal "Iphone 12", golden[2].name
  end

  def test_standard_deviation_for_price
    assert_equal 30.62, @sa.standard_deviation_for_price
  end

  def test_average_invoices
    assert_equal 2.73, @sa.average_invoices_per_merchant
  end


  def test_average_invoices_sd
    #fix fixtures to make merchants, invoices, and items match?
    assert_equal 0, @sa.average_invoices_per_merchant_standard_deviation
  end

  # def test_merchants_by_invoice

  # end


  def test_top_merchants_by_invoice
    assert_equal ["fill in fixtures"], @sa.top_merchants_by_invoice_count
  end

  def test_bottom_merchant_by_invoice
    assert_equal ["fill in fixtures"], @sa.bottom_merchants_by_invoice_count
  end

  def test_top_days_by_invoice
    assert_equal ["Friday"], @sa.top_days_by_invoice_count
  end

  def test_invoice_status

  end


end