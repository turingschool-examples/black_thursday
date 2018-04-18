require './test/test_helper'
require './lib/sales_analyst'
require 'pry'

class InvoiceAnalystTest < Minitest::Test

    def setup
        item_path = "./test/fixture_data/item_repo_fixture.csv"
        merchant_path = "./test/fixture_data/merchant_repo_fixture.csv"
        invoice_path = './test/fixture_data/invoice_1.csv'
        path = {item_data: item_path, merchant_data: merchant_path, invoice_data: invoice_path}
        sales_engine  = SalesEngine.from_csv(path)
        @sales_analyst = SalesAnalyst.new(sales_engine)
    end
        
    def test_average_invoices_per_merchant
        assert_equal 10, @sales_analyst.average_invoices_per_merchant
    end
end