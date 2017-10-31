require_relative 'test_helper'
require './lib/sales_engine'
require 'pry'
require 'csv'

class SalesEngineTest < Minitest:: Test
  def test_a_sales_engine_can_be_instantiated
    result = SalesEngine.new

    assert_instance_of SalesEngine, result
  end

  def test_a_sales_engine_has_an_item_repository
    # se = SalesEngine.new
    skip
    se= SalesEngine.from_csv({
      :items     => "./data/items_fixture_5lines.csv",
      :merchants => "./data/merchants_5lines.csv",
    })
    assert se.item_repository
    assert se.merchant_repository

  end

  def test_merchant_returns_instance_of_Merchant_Repository
    skip
    se= SalesEngine.from_csv({
      # :items     => "./data/items_fixture_5lines.csv",
      :merchants => "./data/merchants_5lines.csv",
    })

    assert_instance_of MerchantRepository, se
  end

  def test_Merchant_Repository_is_fully_loaded_with_instances
skip
    se= SalesEngine.from_csv({
      :merchants => "./data/merchants_5lines.csv",
    })
    result = se.merchants.count
    assert_equal 6, result
  end


  def test_it_can_read_CSV

    se= SalesEngine.from_csv({
      :items     => "./data/items_fixture_5lines.csv",
      :merchants => "./data/merchants_5lines.csv",
    })
    # binding.pry
    assert_equal 6, se.merchant_repository.merchants.count
    assert_equal 8, se.item_repository.items.count # se.merchants#.item_repository #.item_repository.items_store.first.id
    # assert_equal "12334105", se.merchant_repository.merchant_store.first.id

  end
end
