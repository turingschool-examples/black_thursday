require_relative 'test_helper'
require 'csv'
require_relative './../lib/merchant'
require_relative './../lib/merchant_repository'
require_relative './../lib/item'
require_relative './../lib/item_repository'
require_relative './../lib/invoice'
require_relative './../lib/invoice_repository'
require_relative './../lib/sales_engine'

class SalesEngineTest < Minitest::Test
  def setup
    @engine = SalesEngine.from_csv(
      items: './test/fixtures/truncated_items.csv',
      merchants: './test/fixtures/truncated_merchants.csv',
      invoices: './test/fixtures/truncated_invoices.csv'
    )
  end

  def test_it_loads_a_merchant_repository
    assert_equal 60, @engine.merchants.all.count
  end

  def test_it_loads_an_item_repository
    assert_equal 21, @engine.items.all.count
  end

  def test_it_loads_a_invoice_repository
    assert_equal 101, @engine.invoices.all.count
  end

  def test_it_can_find_merchant_by_id
    merchant = @engine.merchants.find_by_id(12334185)

    assert_equal "Madewithgitterxx", merchant.name
    assert_equal 6, merchant.items.length
    assert_equal 263499920, merchant.items.first.id
  end

  def test_it_cant_find_merchant_by_id_if_nil
    merchant = @engine.merchants.find_by_id(nil)

    assert_nil merchant
  end

  def test_it_can_find_item_by_id
    item = @engine.items.find_by_id(263499920)

    assert_equal "Madewithgitterxx", item.merchant.name
    assert_equal Merchant, item.merchant.class
    assert_equal 12334185 , item.merchant.id
  end

  def test_it_cant_find_item_by_id_if_nil
    item = @engine.items.find_by_id(nil)

    assert_nil item
  end

  def test_it_can_find_invoices_by_id
    invoice = @engine.invoices.find_by_id(23)

    assert_instance_of Time, invoice.created_at
    assert_equal Invoice, invoice.class
    assert_equal "12336652", invoice.merchant_id
  end
end
