require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/sales_engine'
require 'pry'

class SalesEngineTest < MiniTest::Test
  attr_reader :se

  def setup
    @se = SalesEngine.new({merchants:"./data/merchants.csv",
    items:"./data/items.csv",
    invoices:"./data/invoices.csv"})
  end

  def test_it_exists
    assert_instance_of SalesEngine, se
  end

  def test_merchants_method
    assert_instance_of MerchantRepo, se.merchants
  end

  def test_items_method
    assert_instance_of ItemRepo, se.items
  end

  def test_invoices_method
    assert_instance_of InvoiceRepo, se.invoices
  end

  def test_can_find_items_by_merchant_id
    merchant = se.merchants.find_by_id(12334112)

    assert_equal 1, merchant.items.count
  end

  def test_can_find_merchant_by_item_id
    item = se.items.find_by_id(263395237)

    assert_equal "jejum", item.merchant.name
  end

  def test_can_find_invoices_from_merchant_id
    merchant = se.merchants.find_by_id(12334159)

    assert_equal 13, merchant.invoices.count
  end

  def test_can_find_find_merchant_by_invoice_id
    invoice = se.invoices.find_by_id(20)

    assert_equal "RnRGuitarPicks", invoice.merchant.name
  end

end
