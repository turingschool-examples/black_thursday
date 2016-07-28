require './test/test_helper'
require './lib/sales_analyst'

class InvoiceAnalystTest < Minitest::Test

  def test_it_knows_the_number_of_invoices_created_on_each_day_of_the_week
    se = SalesEngine.from_csv({ items: "./data/item_sample.csv", merchants: "./data/merchants_sample.csv", invoices: "./data/invoices_sample.csv" })
    ina = SalesAnalyst.new(se).invoice_analyst

    assert_equal true, ina.invoices_per_day.is_a?(Array)
    assert_equal 7, ina.invoices_per_day.length
  end

  def test_it_knows_which_days_of_the_week_have_the_most_sales
    se = SalesEngine.from_csv({ items: "./data/item_sample.csv", merchants: "./data/merchants_sample.csv", invoices: "./data/invoices_sample.csv" })
    ina = SalesAnalyst.new(se).invoice_analyst

    assert_equal ["Friday"], ina.top_days_by_invoice_count
  end

  def test_that_it_finds_distribution_of_invoice_status
    se = SalesEngine.from_csv({ items: "./data/item_sample.csv", merchants: "./data/merchants_sample.csv", invoices: "./data/invoices_sample.csv" })
    ina = SalesAnalyst.new(se).invoice_analyst

    assert_equal 29.00, ina.invoice_status(:pending)
    assert_equal 63.00, ina.invoice_status(:shipped)
    assert_equal 8.00, ina.invoice_status(:returned)
  end


end
