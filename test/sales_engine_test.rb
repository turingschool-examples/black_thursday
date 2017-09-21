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

  def test_can_find_invoice_from_transaction
    assert_instance_of Invoice, new_engine.transactions.all[0].invoice
  end

  def test_can_find_merchant_from_item
    assert_instance_of Merchant, new_engine.items.all[0].merchant
  end

  def test_can_find_merchant_from_invoice
    assert_instance_of Merchant, new_engine.invoices.all[0].merchant
  end

  def test_can_find_items_from_invoice
    assert_instance_of Array, new_engine.invoices.all[0].items
  end

  def test_can_find_customer_from_invoice
    assert_instance_of Customer, new_engine.invoices.all[0].customer
  end

  def test_can_find_items_from_merchant
    assert_instance_of Array, new_engine.merchants.all[0].items
  end

  def test_can_find_customers_from_merchant
    assert_instance_of Array, new_engine.merchants.all[0].customers
  end

  def test_can_check_if_merchant_has_pending_invoice
    assert new_engine.merchants.find_by_id(12335938).has_pending_invoice?
  end

  def test_can_check_if_invoice_is_pending_for_transaction
    assert new_engine.invoices.find_by_id(1752).is_pending?
    refute new_engine.invoices.find_by_id(46).is_pending?
  end

end
