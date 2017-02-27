require './test/test_helper.rb'
require 'csv'
require 'pry'

class SalesAnalystTest < Minitest::Test
  def setup
    @sales_engine = SalesEngine.from_csv({:items => './data/items.csv', :merchants => './data/merchants.csv', :invoices => './data/invoices.csv'})
    @sales_analyst = SalesAnalyst.new(@sales_engine)
  end

  # def test_it_exists
  #   skip
  #   assert @sales_analyst
  # end

  # def test_it_finds_average_number_items
  #   skip
  #   assert_equal 2.88, @sales_analyst.average_items_per_merchant
  # end

  # def test_it_finds_standard_deviation
  #   skip
  #   assert_equal 3.26, @sales_analyst.average_items_per_merchant_standard_deviation
  # end
  
  # def test_merchants_selling_more_items
  #   skip
  #   assert_equal 52, @sales_analyst.merchants_with_high_item_count.length
  # end
  
  # def test_average_price_merchant
  #   skip
  #   assert_instance_of BigDecimal , @sales_analyst.average_item_price_for_merchant(12334159)
  # end

  # def test_average_of_averages
  #   skip
  #   assert_instance_of BigDecimal , @sales_analyst.average_average_price_per_merchant
  # end

  # def test_price_standard_dev
  #   skip
  #   assert_equal 2902.69, @sales_analyst.price_std_dev
  # end

  # def test_average_invoice_per_merchant
  #   skip
  #   assert_equal 10.49, @sales_analyst.average_invoices_per_merchant
  # end

  # def test_top_merchants
  #   skip
  #   assert_equal 12, @sales_analyst.top_merchants_by_invoice_count.length
  # end

  # def test_average_sales_per_day
  #   skip
  #   assert_equal 712.14, @sales_analyst.average_invoices_per_day
  # end

  # def test_average_sales_per_day_std_dev
  #   skip
  #   assert_equal 18.07, @sales_analyst.invoices_per_day_std_dev
  # end

  # def test_days_by_invoice_count
  #   assert_equal ["Wednesday"], @sales_analyst.top_days_by_invoice_count
  # end

  def test_percentage_of_invoices_not_shipped
    assert_equal 29.55, @sales_analyst.invoice_status(:pending)
    assert_equal 56.95, @sales_analyst.invoice_status(:shipped)
    assert_equal 13.5, @sales_analyst.invoice_status(:returned)
  end
end