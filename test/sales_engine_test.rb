require './test/test_helper.rb'
require './lib/sales_engine.rb'

class SalesEngineTest < Minitest::Test
  attr_reader :se

  def setup
    @se = SalesEngine.from_csv({
      :items     => "./test/fixtures/items.csv",
      :merchants => "./test/fixtures/merchants.csv"})
      # :invoice_items => "./data/small_invoice_items.csv",
      # :customers => "./data/small_customers.csv",
      # :transactions => "./data/small_transactions.csv",
      # :invoices  => "./data/small_invoices.csv"})
  end

  def test_sales_engine_from_csv_creates_se_object
    assert_equal Class, @se.class
  end

  def test_it_creates_repos
    assert_equal MerchantRepository, @se.merchants.class
    assert_equal ItemRepository, @se.items.class
    # assert_equal InvoiceRepository, @se.invoices.class
    # assert_equal InvoiceItemRepository, @se.invoice_items.class
    # assert_equal TransactionRepository, @se.transactions.class
  end

end
