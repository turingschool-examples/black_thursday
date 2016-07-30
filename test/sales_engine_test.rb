require './test/test_helper'
require './lib/sales_engine'

class SalesEngineTest < Minitest::Test
  def test_it_finds_all_customers_who_worked_with_a_merchant
    sales_engine = SalesEngine.from_csv({invoices: './data/support/invoices_support.csv',
        customers: './data/support/customer_support.csv'})
    sales_engine.invoices
    sales_engine.customers
    assert_equal 1, sales_engine.find_all_customers_by_merchant_id(12334194).count
  end
end
