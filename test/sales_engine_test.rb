require_relative "test_helper"
require_relative "../lib/sales_engine"

class SalesEngineTest < Minitest::Test

  def test_it_exists
    se = SalesEngine.from_csv({ merchants: "./test/fixtures/merchants_fixture.csv",
                                items: "./test/fixtures/merchants_fixture.csv",
                                invoices: "./test/fixtures/invoices_fixture.csv"})

    assert_instance_of SalesEngine, se
  end

  def test_sales_engine_instantiates_merchant_repository
    se = SalesEngine.from_csv({ merchants: "./test/fixtures/merchants_fixture.csv",
                                items: "./test/fixtures/merchants_fixture.csv",
                                invoices: "./test/fixtures/invoices_fixture.csv"})

    assert_instance_of MerchantRepository, se.merchants
  end

  def test_sales_engine_instantiates_item_repository
    se = SalesEngine.from_csv({ merchants: "./test/fixtures/merchants_fixture.csv",
                                items: "./test/fixtures/merchants_fixture.csv",
                                invoices: "./test/fixtures/invoices_fixture.csv"})

    assert_instance_of ItemRepository, se.items
  end

  def test_sales_engine_instantiates_invoice_repository
    se = SalesEngine.from_csv({ merchants: "./test/fixtures/merchants_fixture.csv",
                                items: "./test/fixtures/merchants_fixture.csv",
                                invoices: "./test/fixtures/invoices_fixture.csv"})

    assert_instance_of InvoiceRepository, se.invoices
  end

  def test_merchant_repository_has_merchants
    se = SalesEngine.from_csv({ merchants: "./test/fixtures/merchants_fixture.csv",
                                items: "./test/fixtures/merchants_fixture.csv",
                                invoices: "./test/fixtures/invoices_fixture.csv"})
    all_merchants = se.merchants.all

    all_merchants.map do |merchant|
      assert_instance_of Merchant, merchant
    end
  end

  def test_item_repository_has_items
    se = SalesEngine.from_csv({ merchants: "./test/fixtures/merchants_fixture.csv",
                                items: "./test/fixtures/merchants_fixture.csv",
                                invoices: "./test/fixtures/invoices_fixture.csv"})

    all_items = se.items.all

    all_items.map do |item|
      assert_instance_of Item, item
    end
  end

  def test_item_is_linked_to_merchant
    se = SalesEngine.from_csv({ merchants: "./test/fixtures/merchants_fixture.csv",
                                items: "./test/fixtures/items_fixture.csv",
                                invoices: "./test/fixtures/invoices_fixture.csv"})

    item = se.items.find_by_id(263395237)

    assert_equal "SeriousCompany", item.merchant.name
  end

  def test_merchant_is_linked_to_item
    se = SalesEngine.from_csv({ merchants: "./test/fixtures/merchants_fixture.csv",
                                items: "./test/fixtures/items_fixture.csv",
                                invoices: "./test/fixtures/invoices_fixture.csv"})

    invoice_1 = se.merchants.find_by_id(12334141)
    invoice_2 = se.merchants.find_by_id(12334185)

    assert_equal "510+ RealPush Icon Set", invoice_1.items.first.name
    invoice_1.items.each do |item|
      assert_instance_of Item, item
    end
    assert_equal 3, invoice_1.items.count
    invoice_2.items.each do |item|
      assert_instance_of Item, item
    end
    assert_equal 3, invoice_2.items.count
  end

  def test_get_all_merchant_items_returns_hash_of_merchants_and_items
    se = SalesEngine.from_csv({ merchants: "./test/fixtures/merchants_fixture.csv",
                                items: "./test/fixtures/items_fixture.csv",
                                invoices: "./test/fixtures/invoices_fixture.csv"})

    merchants_and_items = se.get_all_merchant_items
    merchants = merchants_and_items.keys
    items = merchants_and_items.values.flatten

    sorted_items = items.sort_by {|item| item.id}
    sorted_items = sorted_items.map {|item| item.id}
    sorted_expected_items = se.items.all.sort_by {|item| item.id}
    sorted_expected_items = sorted_expected_items.map {|item| item.id}

    assert_equal se.merchants.all, merchants
    assert_equal sorted_expected_items, sorted_items
  end

  def test_get_all_merchant_prices_returns_hash_of_merchant_and_prices
    se = SalesEngine.from_csv({ merchants: "./test/fixtures/merchants_fixture.csv",
                                items: "./test/fixtures/items_fixture.csv",
                                invoices: "./test/fixtures/invoices_fixture.csv"})

    merchants_and_prices = se.get_all_merchant_prices
    merchants = merchants_and_prices.keys
    prices = merchants_and_prices.values.flatten

    assert_instance_of Hash, merchants_and_prices
    assert_equal se.merchants.all, merchants
    prices.each do |price|
      assert_instance_of BigDecimal, price
    end
  end

  def test_get_one_merchant_prices_returns_array_of_merchant_prices
    se = SalesEngine.from_csv({ merchants: "./test/fixtures/merchants_fixture.csv",
                                items: "./test/fixtures/items_fixture.csv",
                                invoices: "./test/fixtures/invoices_fixture.csv"})

    assert_equal [12.0, 13.5, 7.0],  se.get_one_merchant_prices(12334185)
  end

  def test_search_ir_by_price_returns_all_items_with_given_price
    se = SalesEngine.from_csv({ merchants: "./test/fixtures/merchants_fixture.csv",
                                items: "./test/fixtures/items_fixture.csv",
                                invoices: "./test/fixtures/invoices_fixture.csv" })

    items =  se.search_ir_by_price(12.00)
    item_ids = items.map { |item| item.id }

    assert_equal [263395237, 263395617], item_ids
  end

  def test_find_by_merchant_id_invoices_specific_to_merchant
    se = SalesEngine.from_csv({ merchants: "./test/fixtures/merchants_fixture.csv",
                                items: "./test/fixtures/items_fixture.csv",
                                invoices: "./test/fixtures/invoices_fixture.csv" })

    invoice_1 = se.merchants.find_by_id(12334141)
    invoice_2 = se.merchants.find_by_id(12334185)

    invoice_1.invoices.each do |invoice|
      assert_instance_of Invoice, invoice
    end
    invoice_2.invoices.each do |invoice|
      assert_instance_of Invoice, invoice
    end
    assert_equal 5, invoice_1.invoices.count
    assert_equal 9, invoice_2.invoices.count
    assert_equal 4, invoice_1.invoices.first.id
    assert_equal 1, invoice_2.invoices.first.id
  end

  def test_find_by_invoice_id_returns_merchant_id
    se = SalesEngine.from_csv({ merchants: "./test/fixtures/merchants_fixture.csv",
                                items: "./test/fixtures/items_fixture.csv",
                                invoices: "./test/fixtures/invoices_fixture.csv" })

    invoice_1 = se.invoices.find_by_id(6)
    invoice_2 = se.invoices.find_by_id(18)

    assert_instance_of Invoice, invoice_1
    assert_instance_of Invoice, invoice_2

    assert_equal 12334185, invoice_1.merchant.id
    assert_equal 12334141, invoice_2.merchant.id
  end

end
