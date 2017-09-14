require_relative 'test_helper.rb'
require_relative '../lib/sales_engine.rb'

class SalesEngineTest < Minitest::Test

  def test_sales_engine_exists
    engine = SalesEngine.new({ :items     => "./data/items.csv",
                               :merchants => "./data/merchants.csv",
                               :invoices  => "./data/invoices.csv"
                              })

    assert engine
    assert_instance_of SalesEngine, engine
  end

  def test_sales_engine_loads_merchant_repository
    se = SalesEngine.from_csv({ :items     => "./data/items.csv",
                                :merchants => "./data/merchants.csv",
                                :invoices  => "./data/invoices.csv"
                              })

    assert_instance_of Merchant, se.merchants.all[0]
    assert_instance_of Merchant, se.merchants.all[-1]
    assert_equal 475, se.merchants.all.length
  end

  def test_sales_engine_loads_item_repository
    se = SalesEngine.from_csv({ :items     => "./data/items.csv",
                                :merchants => "./data/merchants.csv",
                                :invoices  => "./data/invoices.csv"
                              })

    assert_instance_of Item, se.items.all[0]
    assert_instance_of Item, se.items.all[-1]
    assert_equal 1367, se.items.all.length
  end

  def test_sales_engine_loads_invoice_repository
    se = SalesEngine.from_csv({ :items     => "./data/items.csv",
                                :merchants => "./data/merchants.csv",
                                :invoices  => "./data/invoices.csv"
                              })

    assert_instance_of Invoice, se.invoices.all[0]
    assert_instance_of Invoice, se.invoices.all[-1]
    assert_equal 4985, se.invoices.all.length
  end

  def test_sales_engine_finds_merchant_by_id
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoices  => "./data/invoices.csv"
    })

    id       = 12335971
    merchant = se.merchants.find_by_id(id)

    assert_equal id, merchant.id
  end

  def test_sales_engine_finds_all_items_by_merchant
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoices  => "./data/invoices.csv"
    })

    id       = 12335971
    merchant = se.merchants.find_by_id(id)
    expected = merchant.items

    assert_equal 1, expected.length
  end

  def test_find_merchant_that_owns_item
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoices  => "./data/invoices.csv"
    })

    id       = 263538760
    item     = se.items.find_by_id(id)
    expected = item.merchant

    assert_equal expected.id, item.merchant_id
    assert_equal 'Blankiesandfriends', expected.name
  end

  def test_sales_engine_finds_all_invoices_by_merchant
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoices  => "./data/invoices.csv"
    })

    id       = 12335690
    merchant = se.merchants.find_by_id(id)
    expected = merchant.invoices

    assert_equal 16, expected.length
  end

  def test_sales_engine_finds_all_invoices_by_other_merchant
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoices  => "./data/invoices.csv"
    })

    id       = 12334189
    merchant = se.merchants.find_by_id(id)
    expected = merchant.invoices

    assert_equal 10, expected.length
  end

  def test_sales_engine_merchant_returns_merchant_from_invoice
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoices  => "./data/invoices.csv"
    })

    invoice      = se.invoices.find_by_id(20)
    merchant     = invoice.merchant

    assert_instance_of Merchant, merchant
    assert_equal 12336163, invoice.merchant.id
  end
end
