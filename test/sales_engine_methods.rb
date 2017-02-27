require_relative '../lib/sales_engine'

module SalesEngineMethods

  def create_sales_engine
    @se = SalesEngine.from_csv({
      :items => "./test/fixtures/items_test.csv",
      :merchants => "./test/fixtures/merchants_test.csv",
      :invoices => "./test/fixtures/invoices_test.csv",
      :invoice_items => "./test/fixtures/invoice_items_test.csv",
      :transactions => "./test/fixtures/transactions_test.csv",
      :customers => "./test/fixtures/customers_test.csv"
    })
  end
end