require 'minitest/autorun'
require 'minitest/pride'
require 'pry'
require_relative '../lib/sales_engine'
require_relative '../test/file_hash_setup'

class SalesEngineTest < Minitest::Test

  attr_reader :file_hash, :se

  include FileHashSetup

  def setup
    super
  end

  def test_from_csv
    se = SalesEngine.from_csv(file_hash)
    assert_equal SalesEngine, se.class
    assert_equal ItemRepository, se.items.class
    assert_equal MerchantRepository, se.merchants.class
    assert_equal InvoiceRepository, se.invoices.class
    assert_equal InvoiceItemRepository, se.invoice_items.class
    assert_equal CustomerRepository, se.customers.class
    assert_equal TransactionRepository, se.transactions.class
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

  def test_prices_of_each_item
    assert_equal Array, se.prices_of_each_item.class
  end

  def test_number_of_invoices
    assert_equal Fixnum, se.number_of_invoices.class
  end

  def test_number_of_invoices_per_merchant
    assert_equal Array, se.number_of_invoices_per_merchant.class
  end

end
