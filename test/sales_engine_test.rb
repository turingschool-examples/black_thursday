require_relative "test_helper"
require_relative "../lib/sales_engine"

class SalesEngineTest < Minitest::Test

  def test_it_exists
    se = SalesEngine.new

    assert_instance_of SalesEngine, se
  end

  def test_sales_engine_instaniates_merchant_repository
    se = SalesEngine.new

    se.from_csv({merchants: "./test/fixtures/merchants_fixture.csv",
                      items: "./test/fixtures/merchants_fixture.csv"})

    assert_instance_of MerchantRepository, se.merchants
  end

  def test_sales_engine_instaniates_merchant_repository
    se = SalesEngine.new

    se.from_csv({merchants: "./test/fixtures/merchants_fixture.csv",
                      items: "./test/fixtures/items_fixture.csv"})

    assert_instance_of ItemRepository, se.items
  end

  def test_merchant_repository_has_merchants
    se = SalesEngine.new

    se.from_csv({merchants: "./test/fixtures/merchants_fixture.csv",
                      items: "./test/fixtures/items_fixture.csv"})
    all_merchants = se.merchants.all

    all_merchants.map do |merchant|
      assert_instance_of Merchant, merchant
    end
  end

  def test_item_repository_has_items
    se = SalesEngine.new

    se.from_csv({merchants: "./test/fixtures/merchants_fixture.csv",
                      items: "./test/fixtures/items_fixture.csv"})

    all_items = se.items.all

    all_items.map do |item|
      assert_instance_of Item, item
    end
  end

  def test_item_is_linked_to_merchant
    se = SalesEngine.new

    se.from_csv({merchants: "./test/fixtures/merchants_fixture.csv",
                      items: "./test/fixtures/items_fixture.csv"})

    item = se.items.find_by_id("263395237")

    assert_equal "Zzz", item.merchant.name
  end

  def test_merchant_is_linked_to_item
    se = SalesEngine.new

    se.from_csv({merchants: "./test/fixtures/merchants_fixture.csv",
                      items: "./test/fixtures/items_fixture.csv"})

    merchant = se.merchants.find_by_id("12334141")

    assert_equal "510+ RealPush Icon Set", merchant.items.first.name
    merchant.items.each do |item|
      assert_instance_of Item, item
    end

    assert_equal 1, merchant.items.count
  end


end
