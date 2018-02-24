require_relative 'test_helper.rb'
require_relative '../lib/sales_engine.rb'
require_relative './master_hash.rb'

class SalesEngineTest < Minitest::Test
  def setup
    test_engine = TestEngine.new.god_hash
    @sales_engine = SalesEngine.new(test_engine)
  end

  def test_sales_engine_initializes
    sales_engine = @sales_engine

    assert_instance_of SalesEngine, sales_engine
  end

  def test_sales_engine_has_merch_repo
    sales_engine = @sales_engine
    merchant_repo = sales_engine.merchants
    merchant = merchant_repo.find_by_name('Shopin1901')

    assert_instance_of MerchantRepository, merchant_repo
    assert_instance_of Merchant, merchant
    assert_equal 12334105, merchant.id
    assert_equal 'Shopin1901', merchant.name
  end

  def test_sales_engine_has_item_repo
    sales_engine = @sales_engine
    item_repo = sales_engine.items
    item = item_repo.find_by_name('Glitter scrabble frames')

    assert_instance_of ItemRepository, item_repo
    assert_instance_of Item, item
    assert_equal 263395617, item.id
    assert_equal 'Glitter scrabble frames', item.name
  end

  def test_sales_engine_has_invoice_repo
    sales_engine = @sales_engine
    invoice_repo = sales_engine.invoices
    invoice = invoice_repo.find_by_id(1)

    assert_instance_of InvoiceRepository, invoice_repo
    assert_instance_of Invoice, invoice
    assert_equal 1, invoice.id
    assert_equal 12335938, invoice.merchant_id
  end

  def test_merchant_items_returns_items_array
    sales_engine = @sales_engine

    merchant = sales_engine.merchants.find_by_id(12334141)
    merchant.items

    assert_equal 1, merchant.items.count
    assert_equal "510+ RealPush Icon Set", merchant.items[0].name
  end

  def test_item_merchant_returns_merchant_instance
    sales_engine = @sales_engine

    item = sales_engine.items.find_by_id(263_395_237)
    item.merchant

    assert_equal "jejum", item.merchant.name
  end

  def test_engine_finds_merchant_customers_via_invoice_repo
    result = @sales_engine.engine_finds_merchant_customers_via_invoice_repo(12_335_955)

    assert_equal 2, result.length
    assert_instance_of Customer, result[0]
  end

  def test_engine_finds_customer_merchants_via_invoice_repo
    result = @sales_engine.engine_finds_customer_merchants_via_invoice_repo(1)

    assert_equal 1, result.length
    assert_instance_of Merchant, result[0]
  end
end
