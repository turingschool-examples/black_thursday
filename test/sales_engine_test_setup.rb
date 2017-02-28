module SalesEngineTestSetup
  attr_reader :sales_engine
  def setup
    @@sales_engine ||= load_sales_engine_data
    @se = @@sales_engine.dup
  end

  private
  def load_sales_engine_data
    puts 'Loading sales engine data!!!!'
    SalesEngine.from_csv({
      :invoices => "./data/invoices.csv",
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :transactions => "./data/transactions.csv",
      :invoice_items => "./data/invoice_items.csv",
      :customers => "./data/customers.csv"
      })
  end
end
