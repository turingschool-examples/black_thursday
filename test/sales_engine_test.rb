require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require 'minitest/pride'
require './lib/sales_engine'
require 'CSV'
require 'pry'

class SalesEngineTest < Minitest::Test
  def test_that_it_exists
    se = SalesEngine.from_csv({
    :items     => "./data/items.csv",
    :merchants => "./data/merchants.csv",
    :invoices => "./data/invoices.csv",
    :invoice_items => "./data/invoice_items.csv"
    })
    assert_instance_of SalesEngine, se
  end

  def test_that_it_has_attributes
    se = SalesEngine.from_csv({
    :items     => "./data/items.csv",
    :merchants => "./data/merchants.csv",
    :invoices => "./data/invoices.csv",
    :invoice_items => "./data/invoice_items.csv"
    })

    assert_instance_of ItemRepository, se.ir
    assert_instance_of MerchantRepository, se.mr
  end

  def test_that_merchant_passes_an_array_of_merchants_to_mr
    se = SalesEngine.from_csv({
    :items     => "./data/items.csv",
    :merchants => "./data/merchants.csv",
    :invoices => "./data/invoices.csv",
    :invoice_items => "./data/invoice_items.csv"
    })
    mr = se.merchants
    actual = mr.merchants_array[0]

    assert_instance_of Merchant , actual
  end

  def test_that_merchant_creates_a_merchant_repository
    se = SalesEngine.from_csv({
    :items     => "./data/items.csv",
    :merchants => "./data/merchants.csv",
    :invoices => "./data/invoices.csv",
    :invoice_items => "./data/invoice_items.csv"
    })
    mr = se.merchants

    assert_instance_of MerchantRepository , mr
  end

  def test_that_items_obtains_array_of_item_hashes
    se = SalesEngine.from_csv({
    :items     => "./data/items.csv",
    :merchants => "./data/merchants.csv",
    :invoices => "./data/invoices.csv",
    :invoice_items => "./data/invoice_items.csv"
    })
    ir = se.items
    actual = ir.items_array[0]

    assert_instance_of Item , actual
  end
end
