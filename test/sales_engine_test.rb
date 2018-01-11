require_relative 'test_helper'
require_relative "../lib/sales_engine"



class SalesEngineTest < Minitest::Test

  attr_reader :se

  def setup
    @se = SalesEngine.from_csv({
      :items     => "./test/fixtures/items_sample.csv",
      :merchants => "./test/fixtures/merchants_sample.csv",
    })
  end

  def test_it_exists
    assert_instance_of SalesEngine, se
  end

  def test_it_initializes_new_items
    assert_instance_of ItemRepository, se.items
  end

  def test_it_initializes_new_merchants
    assert_instance_of MerchantRepository, se.merchants
  end

  def test_it_returns_items_by_id
    items = se.find_item_by_merchant_id(12334195)

    assert items.all? { |item| item.class == Item }
    refute items.all? { |item| item.class == Merchant }
    assert items.all? { |item| item.merchant_id == 12334195 }
    refute items.all? { |item| item.merchant_id == 12332398 }
    assert_equal 10, items.count
    refute_equal 23, items.count
  end

  def test_it_returns_merchants_by_id
    merchant = se.find_merchant_by_id(12334195)

    assert_instance_of Merchant, merchant
    refute_instance_of Item, merchant
    assert merchant.id == 12334195
    refute merchant.id == 12233431
  end

  def test_it_returns_array_of_items_per_merchant
    items_per = se.grab_array_of_merchant_items

    assert_equal 7, items_per.count
    refute_equal 23, items_per.count
  end

  def test_it_grabs_all_merchants
    merchants = se.grab_all_merchants

    assert merchants.all? { |merchant| merchant.class == Merchant }
    refute merchants.all? { |merchant| merchant.class == Item }
  end

  def test_it_grabs_all_items
    items = se.grab_all_items

    assert items.all? { |item| item.class == Item }
    refute items.all? { |item| item.class == Merchant }
  end

end
