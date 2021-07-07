require_relative 'test_helper'
require_relative '../lib/sales_engine'
require 'pry'

class SalesEngineTest < Minitest::Test

  def test_initialize
    salesengine = SalesEngine.from_csv({
      :items => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoices => "./data/invoices.csv"
    })

    assert_instance_of SalesEngine, salesengine
    assert_instance_of ItemRepository, salesengine.items
    assert_instance_of MerchantRepository, salesengine.merchants
  end

  def test_sales_engine_exists
    se = SalesEngine.from_csv({
      :items => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoices => "./data/invoices.csv"
    })

    assert_instance_of SalesEngine, se
  end

  def test_sales_engine_initializes_with_merchant_repository
    se = SalesEngine.from_csv({
      :items => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoices => "./data/invoices.csv"
    })

    assert_instance_of MerchantRepository, se.merchants
  end

  def test_sales_engine_initializes_with_item_repository
    se = SalesEngine.from_csv({
      :items => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoices => "./data/invoices.csv"
    })

    assert_instance_of ItemRepository, se.items
  end

  def test_sales_engine_initializes_with_invoice_repository
    se = SalesEngine.from_csv({
      :items => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoices => "./data/invoices.csv"
    })

    assert_instance_of InvoiceRepository, se.invoices
  end

  def test_merchant_by_merchant_id_gets_merchant
    se = SalesEngine.from_csv({
      :items => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoices => "./data/invoices.csv"
    })
    merchant = se.merchant_by_merchant_id(12335119)

    assert_instance_of Merchant, merchant
  end

  def test_items_by_merchant_id_gets_items
    se = SalesEngine.from_csv({
      :items => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoices => "./data/invoices.csv"
    })
    items = se.items_by_merchant_id(12335119)

    assert_instance_of Item, items[0]
    assert_equal 2, items.count
  end

  def test_invoices_by_merchant_id_gets_invoices
    se = SalesEngine.from_csv({
      :items => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoices => "./data/invoices.csv"
    })
    invoices = se.invoices_by_merchant_id(12335119)

    assert_instance_of Invoice, invoices[0]
    assert_equal 9, invoices.count
  end

end
