require_relative "test_helper"
require_relative "../lib/sales_engine"

class SalesEngineTest < Minitest::Test

  def test_it_exists
    se = SalesEngine.new

    assert_instance_of SalesEngine, se
  end

  def test_sales_engine_instaniates_merchant_repository
    se = SalesEngine.new

    se.from_csv({merchants: "./test/test_data/test_merchants.csv",
                      items: "./test/test_data/test_items.csv"})

    assert_instance_of MerchantRepository, se.merchants
  end

  def test_sales_engine_instaniates_merchant_repository
    se = SalesEngine.new

    se.from_csv({merchants: "./test/test_data/test_merchants.csv",
                      items: "./test/test_data/test_items.csv"})

    assert_instance_of ItemRepository, se.items
  end

  def test_merchant_repository_has_merchants
    se = SalesEngine.new

    se.from_csv({merchants: "./test/test_data/test_merchants.csv",
                      items: "./test/test_data/test_items.csv"})
    all_merchants = se.merchants.all

    all_merchants.map do |merchant|
      assert_instance_of Merchant, merchant
    end
  end

  def test_item_repository_has_items
    se = SalesEngine.new

    se.from_csv({merchants: "./test/test_data/test_merchants.csv",
                      items: "./test/test_data/test_items.csv"})

    all_items = se.items.all

    all_items.map do |item|
      assert_instance_of Item, item
    end
  end



end
