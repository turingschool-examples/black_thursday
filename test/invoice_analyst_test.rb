require_relative 'test_helper'
require_relative '../lib/sales_analyst'
require 'pry'

class InvoiceAnalystTest < Minitest::Test

  def setup
    item_path = "./test/fixture_data/item_repo_fixture.csv"
    merchant_path = "./test/fixture_data/merchant_repo_2.csv"
    invoice_path = './test/fixture_data/invoice_1.csv'
    path = {items: item_path, merchants: merchant_path, invoices: invoice_path}
    sales_engine  = SalesEngine.from_csv(path)
    @sales_analyst = sales_engine.analyst
  end
        
  def test_average_invoices_per_merchant
    assert_equal 10, @sales_analyst.average_invoices_per_merchant
  end

  def test_it_can_find_the_std_per_deviation
    assert_equal 4.0, @sales_analyst.average_invoices_per_merchant_standard_deviation
  end

  def test_it_can_find_the_top_merchants
    assert_instance_of Array, @sales_analyst.top_merchants_by_invoice_count
    assert_equal 12334123, @sales_analyst.top_merchants_by_invoice_count[0].id
  end

  def test_it_can_find_the_lowest_perfomers
    assert_instance_of Array, @sales_analyst.bottom_merchants_by_invoice_count
    assert_equal 12334115, @sales_analyst.bottom_merchants_by_invoice_count[0].id
  end
end