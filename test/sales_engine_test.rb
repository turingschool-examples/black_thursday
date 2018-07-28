require_relative "test_helper.rb"
require_relative "../lib/sales_engine"

class SalesEngineTest < Minitest::Test

  def test_it_exists
    csv_hash = {
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoices => "./data/invoices.csv",
      :invoice_items => "./data/invoice_items.csv",
      :transactions => "./data/transactions.csv"
    }
    se = SalesEngine.from_csv(csv_hash)

    assert_instance_of SalesEngine, se
  end
end
