require './test/test_helper'
require './lib/sales_engine'

class SalesEngineTest < Minitest::Test

  def test_initialize_takes_a_hash_of_repo_data
    assert_instance_of SalesEngine, SalesEngine.new({
      items: [],
      merchants: []
    })
  end

  def test_it_can_have_an_items_repository
    se = SalesEngine.new items: []
    assert_instance_of ItemRepository, se.items
    assert_same se.items, se.repo(:items)
  end

  def test_it_can_have_a_merchants_repository
    se = SalesEngine.new merchants: []
    assert_instance_of MerchantRepository, se.merchants
    assert_same se.merchants, se.repo(:merchants)
  end

  def test_it_can_have_multiple_repositories
    se = SalesEngine.new items: [], merchants: []
    assert_instance_of ItemRepository, se.items
    assert_instance_of MerchantRepository, se.merchants
  end

  def test_it_can_have_no_repos
    se = SalesEngine.new({})
    assert_nil se.items
    assert_nil se.merchants
  end

  def test_initialize_populates_using_given_hash
    merchant_data = { id: 1, name: "Matz" }
    item_data = { id: 1, name: "Ruby" }
    se = SalesEngine.new items: [item_data], merchants: [merchant_data]

    assert_equal "Matz", se.merchants.find_by_id(1).name
    assert_equal "Ruby", se.items.find_by_id(1).name
  end


  def test_from_csv_returns_a_sales_engine
    assert_instance_of SalesEngine, SalesEngine.from_csv({})
  end

  def test_from_csv_populates_new_sales_engine
    se = SalesEngine.from_csv({
      items: "./data/items.csv",
      merchants: "./data/merchants.csv"
    })
    assert_instance_of ItemRepository, se.items
    assert_instance_of MerchantRepository, se.merchants
  end

end
