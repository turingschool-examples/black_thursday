require 'minitest/autorun'
require 'minitest/pride'
require './lib/sales_engine'
require 'simplecov'

SimpleCov.start

class SalesEngineTest < Minitest::Test

  def test_it_exists
    se = SalesEngine.from_csv({:merchants => './test/fixtures/merchants_one.csv'})

    assert_instance_of SalesEngine, se
  end

  def test_it_creates_instance_of_merchant_repository
    se = SalesEngine.from_csv({:merchants => './test/fixtures/merchants_one.csv'})

    assert_instance_of MerchantRepository, se.merchants
  end

  def test_merchant_repository_contains_merchants
    se = SalesEngine.from_csv({:merchants => './test/fixtures/merchants_one.csv'})

    assert_instance_of Merchant, se.merchants.all.first
  end

  def test_it_creates_instance_of_item_repository
    se = SalesEngine.from_csv({:items => './test/fixtures/items_one.csv'})

    assert_instance_of ItemRepository, se.items
  end

  def test_item_repository_contains_items
    se = SalesEngine.from_csv({:items => './test/fixtures/items_one.csv'})

    assert_instance_of Item, se.items.all.first
  end

  def test_it_creates_instance_of_invoice_repository
    se = SalesEngine.from_csv({:invoices => './test/fixtures/invoice_one.csv'})

    assert_instance_of InvoiceRepository, se.invoices
  end

  def test_invoice_repository_contains_invoices
    se = SalesEngine.from_csv({:invoices => './test/fixtures/invoice_one.csv'})

    assert_instance_of Invoice, se.invoices.all.first
  end
end


