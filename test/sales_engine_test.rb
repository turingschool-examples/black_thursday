require './test/test_helper'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/sales_engine'

class SalesEngineTest < Minitest::Test

  def test_it_exists
    sales = SalesEngine.new("./data/items.csv", "./data/merchants.csv", "./data/invoices.csv")

    assert_instance_of SalesEngine, sales
  end

  def test_it_can_make_merchant_repo_instance
    se = SalesEngine.from_csv({
    :items     => "./data/items.csv",
    :merchants => "./data/merchants.csv",
    :invoices  => "./data/invoices.csv"
    })

    assert_instance_of MerchantRepository, se.merchants
  end

  def test_it_can_make_item_repo_instance
    se = SalesEngine.from_csv({
    :items     => "./data/items.csv",
    :merchants => "./data/merchants.csv",
    :invoices  => "./data/invoices.csv"
    })

    assert_instance_of ItemRepository, se.items
  end

  def test_that_merchant_repo_contains_merchants
    se = SalesEngine.from_csv({
    :items     => "./data/items.csv",
    :merchants => "./data/merchants.csv",
    :invoices  => "./data/invoices.csv"
    })

    refute_equal 0, se.merchants.all.size

  end

  def test_that_item_repo_contains_items
    se = SalesEngine.from_csv({
    :items     => "./data/items.csv",
    :merchants => "./data/merchants.csv",
    :invoices  => "./data/invoices.csv"
    })

    refute_equal 1, se.items.all
  end
end
