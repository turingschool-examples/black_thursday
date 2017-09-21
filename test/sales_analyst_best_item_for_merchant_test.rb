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
      :invoices => ".//test/test_fixtures/invoices_medium.csv",
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

  def test_it_finds_valid_merchant_invoices
    assert_instance_of Invoice,  sa.valid_merchant_invoices(12334189)[0]
  end

  def test_it_gets_invoice_id
    assert_equal [636], sa.get_invoice_id(12334189)
  end

  def test_it_finds_invoice_id
    assert_instance_of Array, sa.all_invoice_items(merchant_id)
  end

  def test_it_gets_hash_of_items_and_totals
    actual = {263524984=>0.61558e4, 263516130=>0.878202e4, 263543422=>0.19458e4, 263525980=>0.585468e4, 263511690=>0.29255e3}
   assert_equal actual, sa.item_ids_and_total(merchant_id)
  end

  def test_it_finds_invoice_id
    assert_instance_of Array, sa.all_invoice_items(merchant_id)
  end

  def test_it_finds_highest_value_item
    assert_equal 263516130, sa.highest_value_item(merchant_id)
  end

  def test_it_finds_best_item_for_merchant
    assert_instance_of Item, sa.best_item_for_merchant(merchant_id)
  end

end
