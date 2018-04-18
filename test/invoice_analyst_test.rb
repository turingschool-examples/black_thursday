require './test/test_helper'
require './lib/sales_analyst'
require 'pry'

class InvoiceAnalystTest < Minitest::Test

    def setup
        item_path = "./test/fixture_data/item_repo_fixture.csv"
        merchant_path = "./test/fixture_data/merchant_repo_2.csv"
        invoice_path = './test/fixture_data/invoice_1.csv'
        path = {item_data: item_path, merchant_data: merchant_path, invoice_data: invoice_path}
        sales_engine  = SalesEngine.from_csv(path)
        @sales_analyst = sales_engine.analyst
    end
        
    def test_average_invoices_per_merchant
        assert_equal 14, @sales_analyst.average_invoices_per_merchant
    end

    def test_it_can_find_the_std_per_deviation
        assert_equal 9.11, @sales_analyst.average_invoices_per_merchant_standard_deviation
    end

    def
       assert_instance_of Array, sales_analyst.top_merchants_by_invoice_count
       assert_instance_of Merchant, sales_analyst.top_merchants_by_invoice_count[0]
end