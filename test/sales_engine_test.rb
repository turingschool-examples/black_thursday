require_relative 'test_helper'
require './lib/sales_engine'

class SalesEngineTest < Minitest::Test

  def setup
    @engine = SalesEngine.from_csv({
      :items => './test/fixtures/items_truncated.csv',
      :merchants => './test/fixtures/merchants_truncated.csv',
      :invoices => './test/fixtures/invoices_truncated.csv',
      :invoice_items => './test/fixtures/invoice_items_truncated.csv',
      :customers => './test/fixtures/customers_truncated.csv',
      :transactions => './test/fixtures/transactions_truncated.csv'
    })
  end

  def test_it_exists
    assert_instance_of SalesEngine, @engine
  end

  def test_it_can_open_from_csv_and_populate_repositories
    assert_instance_of ItemRepository, @engine.items
    assert_instance_of MerchantRepository, @engine.merchants
  end

  def test_it_can_find_merchant_from_merchant_repository
    merchant_repository = @engine.merchants
    merchant = merchant_repository.find_by_name('miniaturebikez')

    assert_instance_of Merchant, merchant
    assert_equal 12334113, merchant.id
  end

  def test_it_can_find_item_from_item_repository
    item_repository = @engine.items
    item = item_repository.find_by_name("Glitter scrabble frames")

    assert_instance_of Item, item
    assert_equal 263395617, item.id
  end

  def test_it_can_return_array_of_items_from_item_repository
    assert_instance_of Array, @engine.item_list
    assert_equal 4, @engine.item_list.count
  end

  def test_it_can_return_array_of_merchants_from_merchant_repository
    assert_instance_of Array, @engine.merchant_list
    assert_equal 4, @engine.merchant_list.count
  end

  def test_it_can_return_array_of_invoices_from_invoice_repository
    assert_instance_of Array, @engine.invoice_list
    assert_equal 14, @engine.invoice_list.count
  end
end
