require 'minitest/autorun'
require 'minitest/pride'
require './lib/sales_engine'

class SalesEngineTest < Minitest::Test
attr_reader :se_hash, :se

  def setup
    @se_hash = {:items => './data/test_items.csv',
            :merchants => './data/test_merchant.csv',
            :invoices => './data/test_invoices.csv'}
    @se = SalesEngine.from_csv(se_hash)
  end

  def test_an_instance_of_sales_engine_exists
    se = SalesEngine.new(se_hash)
    assert se.instance_of?(SalesEngine)
  end

  def test_items_instantiates_items_repo
    item = se.items
    assert item.instance_of?(ItemRepository)
  end

  def test_items_instantiates_merchants_repo
    merchants = se.merchants
    assert merchants.instance_of?(MerchantRepository)
  end

  def test_items_returns_item_repo_instance
    item = se.items
    assert_equal 5, item.all.count
  end

  def test_merchants_returns_merchant_repo_instance
    merchants = se.merchants
    assert_equal 5, merchants.all.count
  end

  def test_sales_engine_can_find_by_id
    merchants = se.merchants
    found = merchants.find_by_id(1)
    assert_equal "Schroeder-Jerde", found.name
  end

  def test_invoice_to_merchants_relationship
    invoices = se.invoices.all
    invoice_merchant = invoices[1].merchant
    assert_equal Merchant, invoice_merchant.class
  end

  def test_merchant_to_invoice_relationship
    merchants = se.merchants.all
    merchants_invoice = merchants[0].invoices[0]
    assert_equal Invoice, merchants_invoice.class
  end

  def test_merchant_to_item_relationship
    merchants = se.merchants.all
    merchants_items = merchants[0].items[0]
    assert_equal Item, merchants_items.class
  end

  def test_item_to_merchant_relationship
    items = se.items.all
    items_merchant = items[0].merchant
    assert_equal Merchant, items_merchant.class
  end

  def test_items_can_be_accessed_by_merchant
    merchant = se.items
    items = merchant.find_all_by_merchant_id(1)
    assert_equal 2, items.count
  end

  def test_merchant_with_no_items_returns_empty_array
    merchant = se.items
    items = merchant.find_all_by_merchant_id("6")
    assert_equal [], items
  end

end
