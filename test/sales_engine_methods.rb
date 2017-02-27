require_relative '../lib/sales_engine'

module SalesEngineMethods

  def create_sales_engine
    @se = SalesEngine.from_csv({
    :items => "./test/fixtures/items_robust_sa.csv",
    :merchants => "./test/fixtures/merchants_for_sales_analysis.csv",
    :invoices => "./test/fixtures/invoices_for_sales_analysis.csv",
    :invoice_items => "./test/fixtures/invoice_items_test_data.csv",
    :transactions => "./test/fixtures/transactions_test.csv",
    :customers => "./test/fixtures/customer_test.csv"
  })
  end
end