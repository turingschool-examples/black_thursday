require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/sales_engine'
require_relative '../lib/merchant_repository'
require_relative '../lib/merchant'
require_relative '../lib/item'
require_relative '../lib/item_repository'

class SalesEngineTest < Minitest::Test
  def test_it_exists
    se = SalesEngine.from_csv({
     :items     => "./data/items.csv",
     :merchants => "./data/merchants.csv",
     })
    assert_instance_of SalesEngine, se
  end

  def test_it_starts_with_zero_attributes
    se = SalesEngine.new
    assert_equal nil, se.merchants
    assert_equal nil, se.items
  end

  def test_instance_of_merchant_repository_exists
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
    })
    assert_instance_of MerchantRepository, se.merchants
  end

  def test_it_has_number_merchants
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
    })
    assert_equal 475, se.merchants.merchants.length
  end

  def test_it_can_add_to_merchant_repo
    se = SalesEngine.new
    mr = se.load_merchant_repository("./data/merchants.csv")
    assert_instance_of MerchantRepository, mr
    assert_equal 475, mr.merchants.length
  end

  def test_instance_of_item_repository_exists
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
    })
    assert_instance_of ItemRepository, se.items
  end

  def test_it_has_number_of_items
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
    })
    assert_equal 1367, se.items.items.length
  end

  def test_it_can_add_to_item_repo
    se = SalesEngine.new
    it = se.load_item_repository("./data/items.csv")

    assert_instance_of ItemRepository, it
    assert_equal 1367, it.items.length
  end
end
