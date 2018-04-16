# frozen_string_literal: true

require_relative '../lib/item_repository'
require_relative '../lib/merchant_repository'
require './test/test_helper'
require_relative '../lib/sales_engine'
class SalesEngineTest < Minitest::Test
  def setup
    @se = SalesEngine.from_csv(
      items: './data/items.csv',
      merchants: './data/merchants.csv',
      invoices: './data/invoices.csv'
      )
  end

  def test_it_exists
    assert_instance_of SalesEngine, @se
  end

  def test_all_items_per_by_merchant
    assert_equal 475, @se.all_items_per_merchant.keys.count
    assert_equal 1367, @se.all_items_per_merchant.values.flatten.count
  end

  def test_all_items_prices_per_item
    assert_equal 1367, @se.all_item_prices_per_item.keys.count
    assert_equal 1367,  @se.all_item_prices_per_item.values.flatten.count
  end

  def test_it_contains_repositories
    assert_instance_of ItemRepository, @se.items
    assert_instance_of MerchantRepository, @se.merchants
    assert_instance_of SalesAnalyst, @se.analyst
    assert_instance_of InvoiceRepository, @se.invoices
  end

  def test_all_invoices_per_merchant
    assert_equal 475, @se.all_invoices_per_merchant.keys.count
    assert_equal 4985, @se.all_invoices_per_merchant.values.flatten.count
  end

  def test_test_all_invoices_per_day
    assert_equal 7, se.test_test_all_invoices_per_day.keys.count
    assert_equal 4985, se.all_invoices_per_day.values.flatten.count
    assert_equal 2, se.all_invoices_per_day[1]
    assert_equal 3, se.all_invoices_per_day[2]
  end



end
