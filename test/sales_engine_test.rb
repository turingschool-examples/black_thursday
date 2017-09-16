require 'minitest/autorun'
require 'minitest/pride'
require './lib/sales_engine'

class SalesEngineTest < Minitest::Test
  attr_reader :se

  def setup
    @se = SalesEngine.from_csv({items: "./data/items.csv",
                                merchants: "./data/merchants.csv",
                                invoices: "./data/invoices.csv"})
  end

  def test_it_exists
    assert_instance_of SalesEngine, se
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

  def test_it_can_find_all_items_of_particular_merchant
    merchant = se.merchants.find_by_id(12334185)
    assert_equal 6, merchant.items.count
  end

  def test_it_can_find_merchant_by_item_id
    item = se.items.find_by_id(263395237)
    assert_instance_of Merchant, item.merchant
  end

  def test_average_items
    skip
    assert_equal 2.88, se.average_items_per_merchant
  end

  def test_invoice_class_returns_an_instance_of_merchant
    invoice = se.invoices.find_by_id(20)

    assert_instance_of Merchant, invoice.merchant
  end

  def test_merchant_class_returns_invoices_associated_with_given_merchant
    merchant = se.merchants.find_by_id(12334159)

    assert_equal [], merchant.invoices
  end
end
