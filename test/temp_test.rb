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

  def test_it_can_return_the_invoices_paid_in_full
    actual = @sales_analyst.invoice_paid_in_full?(46)
    assert actual
    actual_2 = @sales_analyst.invoice_paid_in_full?(1752)
    refute actual_2
  end
end
