require './test/test_helper'
require './lib/sales_analyst'
require './lib/sales_engine'

class TempTest < Minitest::Test

  def setup

    @sales_engine = SalesEngine.from_csv({
      :items         => "./data/items.csv",
      :merchants     => "./data/merchants.csv",
      :invoices      => "./data/invoices.csv",
      :invoice_items => "./data/invoice_items.csv",
      :transactions  => "./data/transactions.csv",
      :customers     => "./data/customers.csv"
      })
    @sales_analyst = @sales_engine.analyst

  end

  def test_invoice_status
    actual = @sales_analyst.invoice_status(:pending)
    assert_equal 29.55, actual

    actual = @sales_analyst.invoice_status(:shipped)
    assert_equal 56.95, actual

    actual = @sales_analyst.invoice_status(:returned)
    assert_equal 13.5, actual
  end
  
end
