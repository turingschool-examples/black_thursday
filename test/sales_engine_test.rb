require_relative 'test_helper'
require_relative '../lib/sales_engine'
require 'pry'

# test for the sales engine
class SalesEngineTest < Minitest::Test
  def test_it_exists
    se = SalesEngine.from_csv(items: './test/fixtures/items.csv',
                              merchants: './test/fixtures/merchants.csv')

    assert_instance_of SalesEngine, se
  end

  def test_it_has_item_repo
    se = SalesEngine.from_csv(items: './test/fixtures/items.csv',
                              merchants: './test/fixtures/merchants.csv')
    name = 'Glitter scrabble frames'

    assert_instance_of ItemRepository, se.items
    assert_instance_of Array, se.items.all
    assert_instance_of Item, se.items.find_by_name(name)
    assert_instance_of Item, se.items.find_by_id(1)
  end

  def test_item_repo_integration
    se = SalesEngine.from_csv(items: './test/fixtures/items.csv',
                              merchants: './test/fixtures/merchants.csv')
    string = 'Any colour glitter'

    assert_instance_of Item, se.items.find_all_with_description(string)[0]
    assert_equal [], se.items.find_all_by_price(1000.00)
    assert_equal [], se.items.find_all_by_merchant_id(12_345)
  end

  def test_it_has_merchant_repo
    se = SalesEngine.from_csv(items: './test/fixtures/items.csv',
                              merchants: './test/fixtures/merchants.csv')

    assert_instance_of MerchantRepository, se.merchants
    assert_instance_of Array, se.merchants.all
  end

  def test_merchant_repo_integration_tests
    se = SalesEngine.from_csv(items: './test/fixtures/items.csv',
                              merchants: './test/fixtures/merchants.csv')
    name = 'Shopin1901'

    assert_instance_of Merchant, se.merchants.find_by_name(name)
    assert_instance_of Merchant, se.merchants.find_by_id(1)
    assert_instance_of Merchant, se.merchants.find_all_by_name('Sho')[0]
  end

  def test_initialize
    se = SalesEngine.from_csv(items: './test/fixtures/items.csv',
                              merchants: './test/fixtures/merchants.csv')

    assert_instance_of SalesEngine, se
  end

  def test_pass_merchant_id_to_merchant_repo
    # not sure how to unit test
  end
end
