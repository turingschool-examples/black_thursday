module SalesEngineTestSetup

  attr_reader :sales_engine

  def setup
    @@sales_engine ||= load_data_paths
    @sales_engine = @@sales_engine.dup
  end

  private
  def load_data_paths
    puts "Loading Sales Engine Data"
    SalesEngine.from_csv({
        :merchants    => "./data/merchants.csv",
        :items        => "./data/items.csv",
        :invoices     => "./data/invoices.csv",
        :invoice_items => "./data/invoice_items.csv",
        :transactions => "./data/transactions.csv",
        :customers    => "./data/customers.csv" })
  end
end

#
# class SalesAnalystTest < Minitest::Test
#
#   include SalesEngineTestSetup
#
#   attr_reader :se, :sa
#
#   def setup
#     @sa = SalesAnalyst.new(@se)
#   end
