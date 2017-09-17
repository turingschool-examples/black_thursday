require "./test/test_helper"
require "./lib/sales_engine"
require "./lib/item_repository"
require "./lib/merchant_repository"
require "./lib/merchant"
require "./lib/item"

class SalesEngineTest < Minitest::Test

  attr_reader :new_engine, :csv_hash

  def setup
    @csv_hash = {
      :items     => "./test/test_fixtures/items_medium.csv",
      :merchants => "./test/test_fixtures/merchants_medium.csv",
      :invoices => "./test/test_fixtures/invoices_medium.csv",
      :invoice_items => "./test/test_fixtures/invoice_items_medium.csv",
      :transactions => "./test/test_fixtures/transactions_medium.csv",
      :customers => "./test/test_fixtures/customers_medium.csv"
    }
    @new_engine = SalesEngine.from_csv(csv_hash)
  end

  def test_its_exists
    assert_instance_of SalesEngine, new_engine
  end

  def test_from_csv_creates_new_sales_engine

    new_engine = SalesEngine.from_csv(csv_hash)
    assert_instance_of SalesEngine, new_engine
  end

  def test_items
    assert_instance_of ItemRepository, new_engine.items
    assert_instance_of Array, new_engine.items.all
    assert_instance_of Item, new_engine.items.all[0]
  end

  def test_merchants
    assert_instance_of MerchantRepository, new_engine.merchants
    assert_instance_of Array, new_engine.merchants.all
    assert_instance_of Merchant, new_engine.merchants.all[0]
  end

end
