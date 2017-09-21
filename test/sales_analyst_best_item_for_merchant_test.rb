require "./test/test_helper"
require "./lib/sales_engine"
require "./lib/sales_analyst"
require "./lib/item_repository"
require "./lib/merchant_repository"
require "./lib/merchant"
require "./lib/item"


class TestSalesAnalystBestItemForMerchant < Minitest::Test

  attr_reader :sa, :mod, :merchant_id

  def setup
    csv_hash = {
      :items     => "./test/test_fixtures/items_medium.csv",
      :merchants => "./test/test_fixtures/merchants_medium.csv",
      :invoices => ".//test/test_fixtures/invoices_short.csv",
      :invoice_items => "./data/invoice_items.csv",
      :transactions => "./test/test_fixtures/transactions_medium.csv",
      :customers => "./test/test_fixtures/customers_medium.csv"
    }
    sales_engine = SalesEngine.from_csv(csv_hash)
    @sa = SalesAnalyst.new(sales_engine)
    @mod = BestItemForMerchant
    @merchant_id = 12334189
  end


  def test_it_exists
    assert_instance_of Module, mod
  end

  def test_its_exists
    assert_instance_of SalesAnalyst, sa
  end

  def test_it_says_spork
    assert_equal "spork", sa.testing
  end


  def test_it_finds_valid_merchant_invoices
    assert_equal ["."], mod.valid_merchant_invoices(12334189)
  end
  #
  # def test_it_gets_invoice_id
  #   assert_equal ["."], sa.get_invoice_id(12334189)
  # end

  def test_it_finds_best_item_for_merchant
  assert_equal ["."], sa.best_item_for_merchant(12334189)
  end

end
