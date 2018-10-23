require './test/test_helper'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/sales_engine'

class SalesEngineTest < Minitest::Test

  def test_it_exists
    sales = SalesEngine.new

    assert_instance_of SalesEngine, sales
  end

  def test_sales_can_make_merchant_repo_instance
    se = SalesEngine.from_csv({
  :items     => "./data/items.csv",
  :merchants => "./data/merchants.csv",
  })

  assert_instance_of MerchantRepository, se.merchants
  end

  def test_sales_can_make_item_repo_instance

  end

  def test_that_merchant_repo_contains_merchants

  end

  def test_that_item_repo_contains_items

  end
end
