require 'pry'
require_relative 'test_helper'
require_relative '../lib/sales_engine'

class SalesEngineTest < MiniTest::Test

  def setup
    @files = {:items => './test/data/items_test.csv',
              :merchants => './test/data/merchants_test.csv'}
  end

  def test_from_csv_creates_an_instance_of_sales_engine
    se = SalesEngine.from_csv(@files)

    assert_instance_of SalesEngine, se
  end

  def test_merchant_repo_creates
    se = SalesEngine.from_csv(@files)
    mr = se.merchants

    assert_instance_of MerchantRepository, mr
  end

  def test_items_repo_creates
    se = SalesEngine.from_csv(@files)
    ir = se.items

    assert_instance_of ItemRepository, ir
  end

  def test_if_pull_items_by_merchant_id
    se = SalesEngine.from_csv(@files)
    ir = se.items
    actual = se.items_by_merchant_id(12334105).length

    assert_equal 1, actual
  end

  def test_if_pull_merchant_by_merchant_id
    se = SalesEngine.from_csv(@files)
    mr = se.merchants
    actual = se.merchant_by_merchant_id(12334105)

    assert_instance_of Merchant, actual
  end
end
