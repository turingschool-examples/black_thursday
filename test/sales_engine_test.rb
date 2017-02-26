require 'minitest/autorun'
require 'minitest/pride'
require 'pry'
require_relative '../lib/sales_engine'

class SalesEngineTest < Minitest::Test

  attr_reader :file_hash, :se

  def setup
    @file_hash = {
      items: './data/items.csv',
      merchants: './data/merchants.csv',
      invoices: './data/invoices.csv',
      invoice_items: './data/invoice_items.csv'
    }
    @se = SalesEngine.from_csv(file_hash)
  end

  def test_from_csv
    se = SalesEngine.from_csv(file_hash)
    assert_equal SalesEngine, se.class
    assert_equal ItemRepository, se.items.class
    assert_equal MerchantRepository, se.merchants.class
    assert_equal InvoiceRepository, se.invoices.class
    assert_equal InvoiceItemRepository, se.invoice_items.class
  end

  def test_it_finds_the_number_of_merchants
    assert_equal 475, se.number_of_merchants
  end

  def test_it_can_find_number_of_items
    assert_equal 1367, se.number_of_items
  end

  def test_it_can_find_number_of_items_per_merchant
    assert_equal 475, se.number_of_items_per_merchant.count
  end

end
