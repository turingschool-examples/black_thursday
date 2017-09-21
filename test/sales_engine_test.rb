require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/sales_engine'
require 'csv'

class SalesEngineTest < Minitest::Test
  attr_reader :se

  def setup
    @se = SalesEngine.from_csv({items: "./test/fixtures/items_fixture.csv",
                                merchants: "./test/fixtures/merchant_fixture.csv",
                                invoices: "./test/fixtures/invoices_fixture.csv",
                                invoice_items: "./test/fixtures/invoice_items_fixture.csv",
                                transactions: "./test/fixtures/transactions_fixtures.csv",
                                customers: "./data/customers.csv"})
  end

  def test_it_exists
    assert_instance_of SalesEngine, @se
  end

  def test_engine_can_find_merchant_by_name
    mr = se.merchants
    merchant = mr.find_by_name("MiniatureBikez")
    assert_instance_of Merchant, merchant
    assert_equal "MiniatureBikez", merchant.name
  end

  def test_engine_can_find_item_by_name
    ir   = se.items
    item = ir.find_by_name("Glitter scrabble frames")
    assert_instance_of Item, item
    assert_equal "Glitter scrabble frames", item.name
  end

  def test_find_name_is_case_insensitive
    mr = se.merchants
    merchant = mr.find_by_name("MINIATUREBIKEZ")
    assert_instance_of Merchant, merchant
    assert_equal "MiniatureBikez", merchant.name
  end

  def test_it_can_find_all_items_of_particular_merchant
    merchant = se.merchants.find_by_id(12334185)
    assert_equal 3, merchant.items.count
  end

  def test_it_can_find_merchant_by_item_id
    item = se.items.find_by_id(263395237)
    assert_instance_of Merchant, item.merchant
  end


end
