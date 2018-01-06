require_relative "test_helper"
require_relative "../lib/sales_engine"

class SalesEngineTest < Minitest::Test

  def test_it_exists
    se = SalesEngine.from_csv({ merchants: "./test/fixtures/merchants_fixture.csv",
                                items: "./test/fixtures/merchants_fixture.csv"})

    assert_instance_of SalesEngine, se
  end

  def test_sales_engine_instaniates_merchant_repository
    se = SalesEngine.from_csv({ merchants: "./test/fixtures/merchants_fixture.csv",
                                items: "./test/fixtures/merchants_fixture.csv"})

    assert_instance_of MerchantRepository, se.merchants
  end

  def test_sales_engine_instaniates_merchant_repository
    se = SalesEngine.from_csv({ merchants: "./test/fixtures/merchants_fixture.csv",
                                items: "./test/fixtures/merchants_fixture.csv"})

    assert_instance_of ItemRepository, se.items
  end

  def test_merchant_repository_has_merchants
    se = SalesEngine.from_csv({ merchants: "./test/fixtures/merchants_fixture.csv",
                                items: "./test/fixtures/merchants_fixture.csv"})
    all_merchants = se.merchants.all

    all_merchants.map do |merchant|
      assert_instance_of Merchant, merchant
    end
  end

  def test_item_repository_has_items
    se = SalesEngine.from_csv({ merchants: "./test/fixtures/merchants_fixture.csv",
                                items: "./test/fixtures/merchants_fixture.csv"})

    all_items = se.items.all

    all_items.map do |item|
      assert_instance_of Item, item
    end
  end

  def test_item_is_linked_to_merchant
    se = SalesEngine.from_csv({ merchants: "./test/fixtures/merchants_fixture.csv",
                                items: "./test/fixtures/items_fixture.csv"})

    item = se.items.find_by_id(263395237)

    assert_equal "SeriousCompany", item.merchant.name
  end

  def test_merchant_is_linked_to_item
    se = SalesEngine.from_csv({ merchants: "./test/fixtures/merchants_fixture.csv",
                                items: "./test/fixtures/items_fixture.csv"})

    merchant_1 = se.merchants.find_by_id(12334141)
    merchant_2 = se.merchants.find_by_id(12334185)

    assert_equal "510+ RealPush Icon Set", merchant_1.items.first.name
    merchant_1.items.each do |item|
      assert_instance_of Item, item
    end
    assert_equal 3, merchant_1.items.count
    merchant_2.items.each do |item|
      assert_instance_of Item, item
    end
    assert_equal 3, merchant_2.items.count
  end

  def test_get_all_merchant_items_returns_hash_of_merchants_and_items
    se = SalesEngine.from_csv({ merchants: "./test/fixtures/merchants_fixture.csv",
                                items: "./test/fixtures/items_fixture.csv"})

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
                                items: "./test/fixtures/items_fixture.csv"})

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
                                items: "./test/fixtures/items_fixture.csv"})

    assert_equal [12.0, 13.5, 7.0],  se.get_one_merchant_prices(12334185)
  end

  def test_search_ir_by_price_returns_all_items_with_given_price
    se = SalesEngine.from_csv({ merchants: "./test/fixtures/merchants_fixture.csv",
                                items: "./test/fixtures/items_fixture.csv"})

    items =  se.search_ir_by_price(12.00)
    item_ids = items.map { |item| item.id }

    assert_equal [263395237, 263395617], item_ids
  end

end
