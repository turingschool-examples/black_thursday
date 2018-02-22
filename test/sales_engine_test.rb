# frozen_string_literal: true

require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/sales_engine'
require_relative '../lib/item_repository'
require_relative '../lib/merchant_repository'
require_relative '../lib/invoice_repository'

class SalesEngineTest < Minitest::Test
  def setup
    @se = SalesEngine.from_csv(
      items: './test/fixtures/items.csv',
      merchants: './test/fixtures/merchants.csv',
      invoices: './test/fixtures/invoices.csv'
    )
  end

  def test_it_creates_sales_engine
    assert_instance_of SalesEngine, @se
  end

  def test_it_has_item_repository
    assert_instance_of ItemRepository, @se.items
  end

  def test_it_has_merchant_repository
    assert_instance_of MerchantRepository, @se.merchants
  end

  def test_it_has_invoice_repository
    assert_instance_of InvoiceRepository, @se.invoices
  end
end
