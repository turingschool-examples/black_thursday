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

end
