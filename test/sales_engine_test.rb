require_relative 'test_helper'
require './lib/sales_engine'

class SalesEngineTest < Minitest::Test
  def test_sales_engine_class_exists
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      })
    assert_instance_of SalesEngine, se
  end

  def test_sales_engine_can_take_hash
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      })
    assert se
  end

  def test_it_can_create_a_new_instance_of_merchant_repo_class
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      })
    assert_instance_of MerchantRepository, se.merchants
  end

  def test_it_can_create_a_new_instance_of_item_repo_class
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      })
    assert_instance_of ItemRepository, se.items
  end

  def test_it_can_find_merchant_by_name
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      })
    mr = se.merchants
    merchant = mr.find_by_name("CJsDecor")
    assert merchant
  end

  def test_it_can_find_item_by_name
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      })
    ir   = se.items
    item = ir.find_by_name("510+ RealPush Icon Set")
    assert item
  end

  def test_it_can_find_another_item_by_name
    skip
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      })
    ir   = se.items
    item = ir.find_by_name("Sunstone Pendant!")
    assert item
  end
end
