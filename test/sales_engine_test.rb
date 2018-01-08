require "./test/test_helper"
require "./lib/sales_engine"

class SalesEngineTest < MiniTest::Test

  def setup
    @sales_engine = SalesEngine.from_csv({
      :items      => "./test/fixtures/items_fixtures.csv",
      :merchants  => "./test/fixtures/merchants_fixtures.csv",
      :invoices   => "./test/fixtures/invoices_fixtures.csv",
      :invoice_items => "./test/fixtures/invoice_items_fixtures.csv",
      :transactions => "./test/fixtures/transactions_fixtures.csv",
      :customers => "./test/fixtures/customers_fixtures.csv"
    })
  end

  def test_self_items_returns_instance_of_item_repository
    assert_instance_of ItemRepository, @sales_engine.items
  end

  def test_self_merchants_returns_instance_of_merchant_repository
    assert_instance_of MerchantRepository, @sales_engine.merchants
  end

  def test_self_all_items_returns_an_array_of_items
    assert_equal Array, @sales_engine.all_items.class

    assert_equal Item, @sales_engine.all_items[0].class
  end

  def test_self_all_merchants_returns_an_array_of_merchants
    assert_equal Array, @sales_engine.all_merchants.class

    assert_equal Merchant, @sales_engine.all_merchants[0].class
  end

end
